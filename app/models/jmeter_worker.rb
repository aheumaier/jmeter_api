require 'rubygems'
require 'popen4'

class JmeterWorker < Struct.new(:jmeter_run_id)

  def perform
    @jr_id = jmeter_run_id
    jmeter_obj = JmeterRun.find(@jr_id)
    if jmeter_obj.locked?
     puts 'DEBUG: ...got lock'
    else
      jmeter_obj.locked = true
      jmeter_obj.save
      puts get_jmeter_command
      status =
      POpen4::popen4(get_jmeter_command) do |stdout, stderr, stdin, pid|
        jmeter_obj.jmeter_pid = pid
        jmeter_obj.stderror = stderr.read.strip
        jmeter_obj.stdout = stdout.read.strip
        jmeter_obj.save
      end

      if status.exitstatus == 0 and !status.nil?
        jmeter_obj.finish
        set_commit_message
        puts  'INFO: jmeter_obj has finished with ' + status.inspect
      else
        puts 'ERROR: jmeter_obj has failed'
        jmeter_obj.fatal_error
      end
    end
  end

  def get_jmeter_command
    if Yetting.jmeter_script
      "/app1/jmeter/jmetertest-thumbnailer.sh -f /app1/jmeter/UNITY/access_log.thumbnailer-anaco-vi.app.webcloud.guj.de.20120725.log -r SERVICE.THUMBNAILER-`date +\%Y\%m\%d` -H service.thumbnailer -x /app1/jmeter/UNITY/Grenzwert.service.thumbnailer.jmx "
    else
      Yetting.jmeter_bin_path + "/jmeter -n" + ' ' + get_jmeter_opts
    end
  end

  def get_jmeter_opts
    @project = JmeterRun.find(@jr_id).project
    project_name = project.name
    @jtl_file = "/" + project_name + "_" + Time.now.to_i.to_s + ".jtl"
    jmx_file = project.setting.jmx_file || project_name + ".jmx"
    opts_field =  project.setting.ext_opts || ""
    return opt_string =
    " -t " + Yetting.jmeter_jmx_path + jmx_file +
    " -l " + Yetting.jmeter_jtl_path + jtl_file +
    " -j " + Yetting.jmeter_log +
    " -Jaccess_log=" + project.setting.jmeter_accesslog +
    " -Jcounter=" + project.setting.jmeter_counter.to_s +
    " -Jzeitdauer=" + project.setting.jmeter_period.to_s +
    " -Jjmeter.save.saveservice.url=true" +
    " -Jjmeter.save.saveservice.requestHeaders=true" +
    " -Jjmeter.save.saveservice.responseHeaders=true" +
    " -Jsummariser.name=summary" +
    " -Jsummariser.interval=180" +
    " -Jsummariser.log=true" +
    " -Jsummariser.out=false" +
    " " + opts_field
  end

  def set_commit_message(type='svn')
    ci_message = "JmeterRun " + @project.jmeter_run.id + " for "  + @project.name + " checked in File " + @jtl_file
    case type
      when 'svn'
        %x{ svn add --force * && svn ci -m #{ci__message} --username #{Yetting.svn_user} --password #{Yetting.svn_passwd}}
      when 'git'
        %x{git add . && git commit -am #{ci__message} }
    end
  end

end

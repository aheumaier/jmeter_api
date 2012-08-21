module JmeterExt
  require 'rubygems'
  require 'popen4'

  def validate_env(valid=true)
    begin

      valid = File.exist?('/app1/jmeter/application/bin/jmeter')
      valid = File.exist?('/app1/jmeter/application/bin/jmeter')
      valid = File.exist?('/app1/jmeter/application/bin/jmeter')
    rescue
      raise 'ERROR: validation failed'
    end
  end

  def jmeter_init(jmeter_obj)
    status = POpen4::popen4( jmeter_command) do |stdout, stderr, stdin, pid|
      jmeter_obj.jmeter_pid = pid
      jmeter_obj.stderror = stderr.read.strip
      puts stderr.read.strip
      jmeter_obj.stdout = stdout.read.strip
      jmeter_obj.save
    end
  end


  def jmeter_command
    if Yetting.jmeter_script
      "/app1/jmeter/jmetertest-thumbnailer.sh -f /app1/jmeter/UNITY/access_log.thumbnailer-anaco-vi.app.webcloud.guj.de.20120725.log -r SERVICE.THUMBNAILER-`date +\%Y\%m\%d` -H service.thumbnailer -x /app1/jmeter/UNITY/Grenzwert.service.thumbnailer.jmx "
    else
      puts Yetting.jmeter_bin_path + "/jmeter -n" + ' ' + jmeter_opts
      "cd /tmp && " + Yetting.jmeter_bin_path + "/jmeter -n" + ' ' + jmeter_opts
    end
  end

  def jmeter_command=

  end

  def jmeter_opts
    @project = JmeterRun.find(@jr_id).project
    project_name = @project.name
    @jtl_file = "/" + project_name + "_" + Time.now.to_i.to_s + ".jtl"
    jmx_file = @project.setting.jmx_file || project_name + ".jmx"
    opts_field =  @project.setting.ext_opts || ""
    return opt_string =
        " -t " + Yetting.jmeter_jmx_path + jmx_file +
            " -l " + Yetting.jmeter_jtl_path + @jtl_file +
            " -j " + Yetting.jmeter_log +
            " -Jaccess_log=" + @project.setting.jmeter_accesslog +
            " -Jcounter=" + @project.setting.jmeter_counter.to_s +
            " -Jzeitdauer=" + @project.setting.jmeter_period.to_s +
            " -Jjmeter.save.saveservice.url=true" +
            " -Jjmeter.save.saveservice.requestHeaders=true" +
            " -Jjmeter.save.saveservice.responseHeaders=true" +
            " -Jsummariser.name=summary" +
            " -Jsummariser.interval=180" +
            " -Jsummariser.log=true" +
            " -Jsummariser.out=false" +
            " " + opts_field
  end

  def jmeter_opts=

  end

  def set_commit_message(type='svn')
    ci_message = "JmeterRun " + @jr_id.id.to_s + " for "  + @project.name + " checked in File " + @jtl_file
    Dir.chdir('/app1/jmeter/reports')
    case type
      when 'svn'
        puts %x{ svn add --force * && svn ci -m #{ci_message} --username #{Yetting.svn_user} --password #{Yetting.svn_passwd} }
      when 'git'
        %x{git add . && git commit -am #{ci_message} }
    end
  end



end

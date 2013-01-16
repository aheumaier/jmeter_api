module JmeterDsl
  module Jmeter
    class JmeterCore

      attr_accessor :bin, :work_dir, :access_log, :counter

      def initialize
        @bin = APP_CONFIG['jmeter_bin_path'] || '/usr/bin/jmeter'
        @work_dir = APP_CONFIG['jmeter_work_dir'] || '/tmp'
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

      def access_log
        " -Jaccess_log=" + accesslog
      end

      def counter
        " -Jcounter=" + counter.to_s
      end

      def duration
        " -Jzeitdauer=" + duration.to_s
      end

      def jmeter_opts
        @project = JmeterRun.find(@jr_id).project
        project_name = @project.name
        @jtl_file = "/" + project_name + "_" + Time.now.to_i.to_s + ".jtl"
        jmx_file = @project.setting.jmx_file || project_name + ".jmx"
        opts_field =  @project.setting.ext_opts || ""
        return opt_string =
            " -t " + APP_CONFIG['jmeter_jmx_path'] + jmx_file +
                " -l " + APP_CONFIG['jmeter_jtl_path'] + @jtl_file +
                " -j " + APP_CONFIG['jmeter_log'] +
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

      private

      def jmeter_obj
        if APP_CONFIG['jmeter-script']
          "/app1/jmeter/jmetertest-thumbnailer.sh -f /app1/jmeter/UNITY/access_log.thumbnailer-anaco-vi.app.webcloud.guj.de.20120725.log -r SERVICE.THUMBNAILER-`date +\%Y\%m\%d` -H service.thumbnailer -x /app1/jmeter/UNITY/Grenzwert.service.thumbnailer.jmx "
        else
          puts APP_CONFIG['jmeter_bin_path'] + "/jmeter -n" + ' ' + jmeter_opts
          "cd /tmp && " + APP_CONFIG['jmeter_bin_path'] + "/jmeter -n" + ' ' + jmeter_opts
        end
      end

    end
  end
end

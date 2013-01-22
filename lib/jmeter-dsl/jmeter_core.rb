module JmeterDsl
  module Jmeter
    class JmeterCore

      attr_accessor :bin, :work_dir,
                    :jmeter_pid,
                    :access_log,
                    :counter,
                    :access_log,
                    :counter,
                    :duration,
                    :jmx_file,
                    :jtl_file,
                    :jmeter_log,
                    :jmeter__save__saveservice__url,
                    :jmeter__save__saveservice__requestHeaders ,
                    :jmeter__save__saveservice__responseHeaders ,
                    :summariser__name,
                    :summariser__interval,
                    :summariser__log,
                    :summariser__out

      def initialize(  params_hash )
        @jmeter_log = 'bin/jmeter.log'
        @jmetersave__saveservice__url = true
        @jmetersave__saveservice__url__requestHeaders = true
        @jmeter__save__saveservice__responseHeaders = true
        @summariser__name = 'summary'
        @summariser__interval =180
        @summariser__log = true
        @sumariser__out = false
        @bin = APP_CONFIG['jmeter_bin_path'] || 'bin/jmeter.sh'
        @work_dir = APP_CONFIG['jmeter_work_dir'] || 'bin'
        @jmeter_pid = nil

        # setting runtime params from jmeter_run model
        params_hash.each do |key, value|
          instance_variable_set("@#{key.to_s}", value)
        end
      end

      def runner
        puts 'JmeterInit called'
        jmeter_command = self.bin+' -n '+' '+build_jmeter_opts( self.to_hash )
        status = POpen4::popen4( "echo #{jmeter_command}" ) do |stdout, stderr, stdin, pid|
          self.jmeter_pid = pid
          @stderror = stderr.read.strip
          @stderr.read.strip
          @stdout = stdout.read.strip
        #  jmeter_obj.save
        end
      end

      def to_hash
        hash = {}
        instance_variables.each do |var|
          hash[var.to_s.delete("@")] = instance_variable_get(var)
        end
        hash
      end

      private

      def build_jmeter_opts( attr_hash )
        puts 'calling build_jmeter_opts'
        opts = ''
        attr_hash.each do |key, value|
          opts << '-J'+key.to_s.gsub('__', '.')+'='+value.to_s+' '
        end
        return opts
      end

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

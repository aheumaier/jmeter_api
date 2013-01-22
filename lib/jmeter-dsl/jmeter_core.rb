module JmeterDsl
  module Jmeter
    class JmeterCore

      attr_accessor :bin,
                    :access_log,
                    :counter,
                    :counter,
                    :duration,
                    :jmx_file,
                    :jtl_file,
                    :jmeter__save__saveservice__url,
                    :jmeter__save__saveservice__requestHeaders ,
                    :jmeter__save__saveservice__responseHeaders ,
                    :summariser__name,
                    :summariser__interval,
                    :summariser__log,
                    :summariser__out,
                    :jmeter_pid


      #
      # Set up a complete runnable JmeterObject
      # Expects runtime paramameters amn jmx file
      #
      def initialize(  params_hash )
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

      #
      # Fires up the Jmter Proces in an shell env
      # Return the full process status as stdout & stderr
      #
      def runner
        jmeter_command = self.bin+' -n '+' '+build_jmeter_opts
        puts jmeter_command
        status = POpen4::popen4( "echo #{jmeter_command}" ) do |stdout, stderr, stdin, pid|
          self.jmeter_pid = pid
          #stderror = stderr.read.strip
          #@stderr.read.strip
          #@stdout = stdout.read.strip
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

      def build_jmeter_opts
        opts = ''
        opts << set_jmx_file
        opts << set_jtl_file
        opts <<  set_log_file
        opts << set_summarizer
        opts << set_accesslog
        opts << set_threads
        opts << set_period
        opts << set_counter
        opts << set_troughput

        end
        return opts
      end

      def set_summarizer(opt_str = '')
        self.to_hash.each do |key, value|
          opt_str << '-J'+key.to_s.gsub('__', '.')+'='+value.to_s+' ' if key.match(/summariser/)
          opt_str << '-J'+key.to_s.gsub('__', '.')+'='+value.to_s+' ' if key.match(/saveservice/)
        end
        return opt_str
      end

      def set_jmx_file
        store_dir = '../definition_files/' # JmxDefinitionFile.last.df.store_dir
        '-t '+store_dir+self.jmx_file+' '
      end

      def set_jtl_file
        '-j '+self.jtl_file+' '
      end

      def set_log_file
        '-l jmeter.log '
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

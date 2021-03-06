module JmeterDsl
  module Jmeter
    class JmeterCore

      attr_accessor :access_log,
                    :counter,
                    :threads,
                    :duration,
                    :throughput,
                    :jmx,
                    :jtl,
                    :jmeter_pid,
                    :jmeter_stderror,
                    :jmeter_stdout

      #
      # Set up a complete runnable JmeterObject
      # Expects runtime paramameters amn jmx file
      #
      def initialize( params_hash )
        @bin = APP_CONFIG['jmeter_bin_path'] || './jmeter.sh'
        @work_dir = APP_CONFIG['jmeter_work_dir'] || 'public/bin'
        @store_dir = Rails.root+'public/definition_files/'
        @jmeter_pid = nil
        @jmeterproperties = ''
        @defined_properties = %w[access_log threads counter duration throughput]

        params_hash.each do |key, value|
          if  key.match(/^jprop_/)
            instance_variable_set("@#{key.to_s.gsub('jprop_', '')}", value)
          end
        end
      end

      #
      # Fires up the Jmter Proces in an shell env
      # Return the full process status as stdout & stderr
      #
      def runner
        build_jmeter_opts
        jmeter_command = @bin+' -n '+' '+ @jmeterproperties
        change_to_workdir()
        puts jmeter_command
        system(jmeter_command)
      end

      def to_hash
        hash = {}
        instance_variables.each do |var|
          hash[var.to_s.delete("@")] = instance_variable_get(var)
        end
        hash
      end

      def build_jmeter_opts
        instance_variables.each do |var|
          add_jmeterproperty({ var.to_s.delete("@") => instance_variable_get(var) })
        end
      end

      def add_jmeterproperty( property )
        property.each do |key, value|
          if @defined_properties.include?(key.to_s)
            if key.match(/access_log/)
              @jmeterproperties << ' -J'+key+'='+@store_dir.to_path+value.to_s
            else
              @jmeterproperties << ' -J'+key+'='+value.to_s
            end
          elsif key.match(/jmx/)
            @jmeterproperties << ' -t '+@store_dir.to_path+value
          elsif key.match(/jtl/)
            @jmeterproperties << ' -l '+@store_dir.to_path+value
          end
        end
      end

      def change_to_workdir
        Dir.chdir(Rails.root+'public/bin')
      end
    end
  end
end


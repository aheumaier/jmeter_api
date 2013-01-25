module JmeterDsl
  module Jmeter
    class JmeterCore

      attr_accessor :accesslog,
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
        @store_dir = '/home/aheumaier/codebox/site/public/definition_files/'
        @jmeter_pid = nil
        @jmeterproperties = ''
        @defined_properties = %w[accesslog threads counter duration throughput]

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
            @jmeterproperties << ' -J'+key+'='+value.to_s
          elsif key.match(/jmx/)
            @jmeterproperties << ' -t '+@store_dir+value
          elsif key.match(/jtl/)
            @jmeterproperties << ' -l '+@store_dir+value
          end
        end
      end

      def change_to_workdir
        Dir.chdir(Rails.root+'public/bin')
      end
    end
  end
end


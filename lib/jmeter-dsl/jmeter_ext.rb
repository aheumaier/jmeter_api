module JmeterDsl
  module Jmeter

    def validate_env(valid=true)
      begin

        valid = File.exist?('/app1/jmeter/application/bin/jmeter')
        valid = File.exist?('/app1/jmeter/application/bin/jmeter')
        valid = File.exist?('/app1/jmeter/application/bin/jmeter')
      rescue
        raise 'ERROR: validation failed'
      end
    end

    def ci_message
      "JmeterRun " + @jr_id.id.to_s + " for "  + @project.name + " checked in File " + @jtl_file
    end

    def commit(type='svn')
      Dir.chdir('/app1/jmeter/reports')
      case type
        when 'svn'
          puts %x{ svn add --force * && svn ci -m #{ci_message} --username #{APP_CONFIG['svn_user']} --password #{APP_CONFIG['svn_passwd']} }
        when 'git'
          %x{git add . && git commit -am #{ci_message} }
      end
    end
  end
end

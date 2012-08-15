require "jmeter_connector/version"

module JmeterConnector
  def initialize
   validate_env
  end

  def validate_env
    begin

    rescue
      raise 'ERROR: validation failed'
    end
  end


end

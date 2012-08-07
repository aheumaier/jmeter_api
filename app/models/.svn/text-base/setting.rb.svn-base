class Setting < ActiveRecord::Base
  attr_accessible :jmeter_accesslog, :jmeter_counter, :jmeter_period, :jmeter_threads, :jmeter_troughput, :jmx_file, :jtl_file, :remote_server, :ext_opts

  belongs_to :project

  after_initialize :set_defaults

  def set_defaults
    self.jmeter_accesslog = "public/testplans/jmeter_default_access.log"
    self.jmeter_counter = 1
    self.jmeter_period = 3600 
    self.jmeter_threads = 4 
    self.jmeter_troughput = 500
    self.jmx_file = "/Grenzwert.UNITY.20120705.jmx"
    self.jtl_file = "/default_project_" + Time.now.to_i.to_s + ".jtl"
    self.remote_server = ""
    self.ext_opts = ""
  end

  def update_settings(params)
    params.each do |key,value|
      case key
      when 'jmeter_threads'
         self.jmeter_threads = value
      when 'jmeter_counter'
         self.jmeter_counter = value
      when 'jmeter_period'
         self.jmeter_period = value
      when 'jmeter_troughput'
         self.jmeter_troughput = value
      when 'jmx_file'
         self.jmx_file = value
      when 'jtl_file'
         self.jtl_file = value
      when 'remote_server'
         self.remote_server = value
      else 
       logger.debug "DEBUG: :"  + key + ' not used'
      end

    end
    self.save!
  end

end

class JmeterSetting < ActiveRecord::Base

  attr_accessible :jmeter_accesslog, :jmeter_counter, :jmeter_period, :jmeter_threads,
                  :jmeter_troughput, :jmx_file, :jtl_file, :remote_server, :ext_opts, :jtl_path

  belongs_to :jmeter_run

  #validates_presence_of

  after_save :set_defaults

  def set_defaults
    self.jmeter_accesslog = ""
    self.jmx_file = ""+ self.jmeter_run.description + '.jmx'
    self.jmeter_counter = 1
    self.jmeter_period = 3600 
    self.jmeter_threads = 20
    self.jmeter_troughput = 600
    self.jmx_file = ""
    self.jtl_file =  "run_log_" + Time.now.to_i.to_s + ".jtl"
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
        when 'jtl_path'
          self.jtl_file = value
        else
          logger.debug "DEBUG: :"  + key + ' not used'
      end
    end


    self.save!
  end


  def valid_file?(a)
     File.exist?(a)
  end

end

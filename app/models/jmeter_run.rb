class JmeterRun < ActiveRecord::Base
  include JmeterDsl

  attr_accessible :description, :project_id, :state, :stderror, :stdout, :jmeter_pid,
                  :locked, :jmeter_accesslog, :jmeter_counter, :jmeter_period, :jmeter_threads,
                  :jmeter_troughput, :jmx_file, :jtl_file, :remote_server, :ext_opts, :log_definition_file_id,
                  :jmx_definition_file_id

  belongs_to :project, :touch => true
  belongs_to :jmx_definition_file, :touch => true
  belongs_to :log_definition_file, :touch => true

  validates_presence_of :jmx_file, :jtl_file, :description, :project_id

  before_validation :build_settings

  def build_settings
    self.jmx_file = self.jmx_definition_file.df_name unless self.jmx_definition_file.nil?
    self.jmeter_accesslog = self.log_definition_file.df_name unless self.log_definition_file.nil?
    self.jtl_file = "jmeter_run_log_" + Time.now.to_i.to_s + ".jtl"
  end

  #
  #def update_settings(params)
  #  params.each do |key,value|
  #    case key
  #      when 'jmeter_threads'
  #        self.jmeter_threads = value
  #      when 'jmeter_counter'
  #        self.jmeter_counter = value
  #      when 'jmeter_period'
  #        self.jmeter_period = value
  #      when 'jmeter_troughput'
  #        self.jmeter_troughput = value
  #      when 'jmx_file'
  #        self.jmx_file = value
  #      when 'jtl_file'
  #        self.jtl_file = value
  #      when 'remote_server'
  #        self.remote_server = value
  #      when 'jtl_path'
  #        self.jtl_file = value
  #      else
  #        logger.debug "DEBUG: :"  + key + ' not used'
  #    end
  #  end

  state_machine :initial => :idle do
    before_transition :idle => :running, :do => :perform_test
    before_transition :running => :killed, :do => :kill_process
    before_transition :running => :finished, :do => :validate_results
    before_transition :running => :failed, :do => :send_error_results
     
    event :push_start do 
      transition :idle => :running
    end

    event :kill do
      transition :running => :killed
    end

    event :finish do
      transition :running => :finished
    end

    event :kill do
      transition :running => :killed
    end

    event :fatal_error do
      transition :running => :failed
    end

    event :finish do
      transition :running => :finished
    end
   
    state :running, :pending do
      validates_presence_of :description
    end
  end

  def perform_test
    Delayed::Job.enqueue JmeterWorker.new( self.id ) 
  end

  def kill_process
    Rails.logger.debug "Killing jmeter process ..."
    self.stdout = %[/bin/stoptest.sh]
  end

  def validate_results
    Rails.logger.debug "Dummy: validate_results"
  end

  def send_error_results
    Rails.logger.error self.stdout
    Rails.logger.error self.stderror
  end

  def locked?
    return self.locked
  end

  def lock
    self.locked = true
    self.save!
  end


end

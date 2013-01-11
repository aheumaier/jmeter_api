class JmeterRun < ActiveRecord::Base
  include JmeterExt

  attr_accessible :description, :jmx_source, :project_id, :state, :stderror, :stdout, :jmeter_pid,
                  :locked

  belongs_to :project, :touch => true
  has_one :jmeter_setting, :dependent=> :nullify
  has_one :jmx_definition_file, :dependent=> :nullify
  has_one :log_definition_file, :dependent=> :nullify
  accepts_nested_attributes_for :jmeter_setting, :allow_destroy => true

  before_save :create_settings

  def create_settings
    if self.jmeter_setting == nil
      self.build_jmeter_setting
      self.save!
    end
  end

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
    self.stdout = %[/app1/jmeter//application/bin/stoptest.sh]
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

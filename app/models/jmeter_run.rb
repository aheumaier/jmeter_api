class JmeterRun < ActiveRecord::Base
  attr_accessible :description, :jmx_source, :project_id, :state, :stderror, :stdout, :jmeter_pid,
                  :locked

  belongs_to :project, :touch => true

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
    if self.jmeter_pid != 0
      Rails.logger.info "kill -9 #{self.jmeter_pid}"
    end
  end

  def validate_results
    Rails.logger.debug "Dummy: validate_results"
  end

  def send_error_results
  end

  def locked?
    return self.locked
  end

  def self.find_by_param(p_id)
    if p_id.match(/^[\d]+(\.[\d]+){0,1}$/)
      Project.find_by_id(p_id)
    else
      Project.find_by_name(p_id)
    end
  end


end

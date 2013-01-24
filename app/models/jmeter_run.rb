class JmeterRun < ActiveRecord::Base
  include JmeterDsl

  attr_accessible :description,
                  :project_id,
                  :log_definition_file_id,
                  :jmx_definition_file_id,
                  :state,
                  :stderror,
                  :stdout,
                  :jmeter_pid,
                  :locked,

                  :jprop_accesslog,
                  :jprop_counter,
                  :jprop_period,
                  :jprop_threads,
                  :jprop_throughput,
                  :jprop_jmx,
                  :jprop_jtl,
                  :jprop_remote_server,
                  :ext_opts


  belongs_to :project, :touch => true
  belongs_to :jmx_definition_file, :touch => true
  belongs_to :log_definition_file, :touch => true

  validates_presence_of :jprop_jmx, :jprop_jtl, :description, :project_id

  before_validation :build_settings

  def build_settings
    self.jprop_jmx = self.jmx_definition_file.df_name unless self.jmx_definition_file.nil?
    self.jprop_accesslog = self.log_definition_file.df_name unless self.log_definition_file.nil?
    self.jprop_jtl = "jmeter_run_log_" + Time.now.to_i.to_s + ".jtl"
  end

  state_machine :initial => :idle do
    before_transition :idle => :running, :do => :perform_test
    before_transition :running => :killed, :do => :kill_process
    before_transition :running => :finished, :do => :validate_results
    before_transition :running => :failed, :do => :send_error_results
    before_transition :killed => :running, :do => :perform_test
    before_transition :finished => :running, :do => :perform_test
     
    event :push_start do 
      transition :idle => :running
    end

    event :kill do
      transition :running => :killed
    end

    event :finish do
      transition :running => :finished
    end

    event :fatal_error do
      transition :running => :failed
    end
   
    state :running, :idle do
      validates_presence_of :description
    end

    event :repeat do
      transition [:finished,:killed,:failed] => :running
    end
  end

  def perform_test
    Delayed::Job.enqueue JmeterWorker.new( self.id ) 
  end

  def kill_process
    Rails.logger.debug "Killing jmeter process ..."
    Dir.chdir(Rails.root+'public/bin')
    self.stderror = %x{./stoptest.sh}
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

  def get_jmeter_attributes
    attributes = self.attributes.select {|key, value| /^jprop_/.match(key.to_s)}
    attributes.merge(:jprop_ext_opts=> self.ext_opts)
    return attributes
  end

  def lock
    self.locked = true
    self.save!
  end


end

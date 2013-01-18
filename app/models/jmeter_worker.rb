class JmeterWorker < Struct.new(:jmeter_run_id)
  include JmeterDsl

  def perform
    puts "perform called"

    jmeter_run_obj = JmeterRun.find_by_id(jmeter_run_id)

    # lock object or raise
    jmeter_run_obj.lock unless jmeter_run_obj.locked?

    # instantiate JmeterCore Object
    jmeter_core_inst = JmeterDsl::Jmeter::JmeterCore.new()

    # run test plan
    status = jmeter_core_inst.jmeter_init(jmeter_run_obj)

    if status.exitstatus == 0 and !status.nil?
      jmeter_run_obj.finish
      self.commit
      puts  'INFO: jmeter_obj has finished with ' + status.inspect
    else
      puts 'ERROR: jmeter_obj has failed'
      jmeter_run_obj.fatal_error
    end
  end
end

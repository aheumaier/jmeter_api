class JmeterWorker < Struct.new(:jmeter_run_id)
  include JmeterDsl

  def perform
    puts "perform called"
    @jr_id = jmeter_run_id
    jmeter_run_obj = JmeterRun.find_by_id(@jr_id)
    if jmeter_run_obj.locked?
     puts 'DEBUG: ...got lock'
    else
      jmeter_run_obj.lock

      status = self.jmeter_init(jmeter_run_obj)

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

end

class JmeterWorker < Struct.new(:jmeter_run_id)
  include JmeterExt

  def perform
    puts "perform called"
    @jr_id = jmeter_run_id
    jmeter_run_obj = JmeterRun.find(@jr_id)
    if jmeter_obj.locked?
     puts 'DEBUG: ...got lock'
    else
      jmeter_run_obj.lock

      status = self.jmeter_start(jmeter_run_obj)

      if status.exitstatus == 0 and !status.nil?
        jmeter_run_obj.finish
        self.set_commit_message('svn')
        puts  'INFO: jmeter_obj has finished with ' + status.inspect
      else
        puts 'ERROR: jmeter_obj has failed'
        jmeter_run_obj.fatal_error
      end
    end
  end

end

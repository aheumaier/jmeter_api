class DashboardController < ApplicationController
  def index
    @jobs ||= Delayed::Job.all
    @jobs_failed = Delayed::Job.where(:failed_at => !nil)
    @jmeter_runs_idle = JmeterRun.where(:state => 'idle')
    @jmeter_runs_running = JmeterRun.where(:state => 'running')
  end

  def clear_queue
    Delayed::Job.delete_all
    respond_to do |format|
      format.html { redirect_to dashboard_index_path, :notice => 'JobQueue was successfully flushed.' }
    end
  end

end

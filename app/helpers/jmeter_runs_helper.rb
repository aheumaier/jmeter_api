module JmeterRunsHelper

  def jmeter_runs_path( parent_project)
    "/projects/#{@project}/jmeter_runs"
  end

  def jmeter_run_path(*lalala)
    "/projects/#{@project}/jmeter_runs/#{@jmeter_run.id}"
  end
end

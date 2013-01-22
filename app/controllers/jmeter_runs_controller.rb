##
# This class represents...

class JmeterRunsController < ApplicationController

  # GET /jmeter_runs/index
  def index
    @project ||= Project.find_by_param(params[:project_id])
    @jmeter_runs ||= JmeterRun.find_all_by_project_id(params[:project_id])

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # GET /jmeter_runs/1
  def show
    @project ||= Project.find_by_id(params[:project_id])
    @jmeter_run ||= JmeterRun.find_by_id(params[:id], :include => [:log_definition_file, :jmx_definition_file] )

    respond_to do |format|
      format.html  #{ render :text => @jmeter_run.to_s }# show.html.haml
    end
  end

  # GET /jmeter_runs/new
  def new
    @project ||=  Project.find_by_param(params[:project_id])
    @jmeter_run = @project.jmeter_runs.build

    respond_to do |format|
      format.html # new.html.haml
    end
  end

  # GET /jmeter_runs/1/edit
  def edit
    @project ||=  Project.find_by_param(params[:project_id])
    @jmeter_run ||= JmeterRun.find(params[:id])
  end

  # POST /jmeter_runs
  def create
    @project ||=  Project.find_by_param(params[:project_id])
    @jmeter_run = @project.jmeter_runs.build(params[:jmeter_run])

    respond_to do |format|
      if @jmeter_run.save
        format.html { redirect_to project_jmeter_runs_path(@project), :notice => 'JmeterRun was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /jmeter_runs/1
  def update
    @project ||=  Project.find_by_param(params[:project_id])
    @jmeter_run ||=  JmeterRun.find(params[:id])

    respond_to do |format|
      if @jmeter_run.update_attributes(params[:jmeter_run])
        format.html { redirect_to project_jmeter_run_path(@project, @jmeter_run),
                                  :notice => 'Jmeter run was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /jmeter_runs/1
  def destroy
    @jmeter_run ||=  JmeterRun.find(params[:id])
    @project = @jmeter_run.project_id
    @jmeter_run.destroy

    respond_to do |format|
      format.html { redirect_to project_jmeter_runs_path(@project), :notice => 'Jmeter run was successfully deleted.' }
    end
  end

  # GET /jmeter_runs/1/status
  def status
    @jmeter_run ||=  JmeterRun.find(params[:id])
    @jmeter_run_state ||= @jmeter_run.state
    respond_to do |format|
      format.html { render :text => @jmeter_run_state  }
    end
  end

  # GET /jmeter_runs/1/start
  def start
    @jmeter_run ||=  JmeterRun.find(params[:id])
    @project = @jmeter_run.project_id
    @jmeter_run_start =  @jmeter_run.push_start

    respond_to do |format|
      format.html { redirect_to project_jmeter_run_path(@project, @jmeter_run), :notice => 'JmeterRun was successfully started.' }
    end
  end

  # GET /jmeter_runs/1/kill
  def kill
    @jmeter_run ||=  JmeterRun.find(params[:id])
    @project = @jmeter_run.project_id
    @jmeter_run_state =  @jmeter_run.kill
    respond_to do |format|
      format.html { redirect_to project_jmeter_run_path(@project, @jmeter_run), :notice => 'JmeterRun was successfully  killed.' }
    end
  end

  # GET /jmeter_runs/current
  def current
    @jmeter_run ||=  JmeterRun.find_last_by_project_id(params[:project_id])

    respond_to do |format|
      format.html { render :text => @jmeter_run  }
    end
  end
end

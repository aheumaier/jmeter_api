class JmeterRunsController < ApplicationController

  def index
    @project ||= Project.find_by_id(params[:project_id])
    @jmeter_runs ||= JmeterRun.find_all_by_project_id(params[:project_id])

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # GET /jmeter_runs/1
  # GET /jmeter_runs/1.json
  def show
    @project ||= Project.find_by_id(params[:project_id])
    @jmeter_run ||= JmeterRun.find_by_id(params[:id])

    respond_to do |format|
      format.html  #{ render :text => @jmeter_run.to_s }# show.html.erb
    end
  end

  # GET /jmeter_runs/new
  # GET /jmeter_runs/new.json
  def new
    @project ||=  Project.find_by_param(params[:project_id])
    @jmeter_run = @project.jmeter_runs.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /jmeter_runs/1/edit
  def edit
    @project ||=  Project.find_by_param(params[:project_id])
    @jmeter_run ||= JmeterRun.find(params[:id])
  end

  # POST /jmeter_runs
  # POST /jmeter_runs.json
  def create
    @project ||=  Project.find_by_param(params[:project_id])
    @jmeter_run = @project.jmeter_runs.build(params[:jmeter_run])

    respond_to do |format|
      if @jmeter_run.save
        format.html { redirect_to project_jmeter_runs_path(@project), :notice => 'JmeterRun was successfully
created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /jmeter_runs/1
  # PUT /jmeter_runs/1.json
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
  # DELETE /jmeter_runs/1.json

  def destroy
    @jmeter_run ||=  JmeterRun.find(params[:id])
    @jmeter_run.destroy

    respond_to do |format|
      format.html { redirect_to project_jmeter_runs_path(@jmeter_run.project_id) }
      format.json { head :no_content }
    end
  end

  def status
    @jmeter_run ||=  JmeterRun.find(params[:id])
    @jmeter_run_state ||= @jmeter_run.state
    respond_to do |format|
      format.html { render :text => @jmeter_run_state  }
      format.json { render :json => @jmeter_run_state  }
    end
  end


  def start
    @jmeter_run ||=  JmeterRun.find(params[:id])
    @jmeter_run_start =  @jmeter_run.push_start
    respond_to do |format|
      format.json {  head :no_content  }
    end
  end

  def kill
    @jmeter_run ||=  JmeterRun.find(params[:id])
    @jmeter_run_state =  @jmeter_run.kill
    respond_to do |format|
      format.html { redirect_to @jmeter_run, :notice => 'JmeterRun was successfully killed.' }
      format.json { render :json => @jmeter_run_state }
    end
  end

  def current
    @jmeter_run ||=  JmeterRun.find_last_by_project_id(params[:project_id])

    respond_to do |format|
      format.html { render :text => @jmeter_run  }
      format.json { render :json => @jmeter_run }
    end
  end
end

class ProjectsController < ApplicationController

  # GET /projects
  def index
    @projects ||=  Project.all
    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # GET /projects/1
  def show
    @project ||= Project.find_by_param(params[:id])
    @jmeter_runs ||= JmeterRun.find_all_by_project_id(@project.id)

    if @project
      respond_to do |format|
        format.html # show.html.haml
      end
    else
      respond_to do |format|
        format.html { render :text => "Entry not found \n"}
      end
    end
  end


# GET /projects/new
  def new
    @project = Project.new

  # respond_to do |format|
    #  format.html # new.html.haml
    #end
  end

# GET /projects/1/edit
  def edit
    @project ||= Project.find(params[:id])
  end

# POST /projects
  def create
    @project = Project.new(params[:project])
    @project.find_or_create_reports_home(params[:project])
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, :notice => 'Project was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

# PUT /projects/1
  def update
    @project ||= Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to project_url, :notice => 'Project was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

# DELETE /projects/1
  def destroy
    @project ||= Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
    end
  end
end
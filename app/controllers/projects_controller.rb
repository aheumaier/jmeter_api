class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    if params[:id].match(/^[\d]+(\.[\d]+){0,1}$/)
      Rails.logger.warn 'find a number'
      @project = Project.find_by_id(params[:id])
    else
      Rails.logger.warn 'find an string'
      @project = Project.find_by_name(params[:id])
    end

    if !@project.nil?
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @project }
      end
    else
      respond_to do |format|
        #format.html # show.html.erb
        format.json { render :json => "Entry not found \n" }
      end
    end
  end


# GET /projects/new
# GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @project }
    end
  end

# GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

# POST /projects
# POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, :notice => 'Project was successfully created.' }
        format.json { render :json => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.json { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

# PUT /projects/1
# PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, :notice => 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

# DELETE /projects/1
# DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def settings
    if params[:name]
      @project_settings = Project.find_by_name(params[:name]).setting
    else
      @project_settings = Project.find(params[:id]).setting
    end
    puts @project_settings.inspect
    @project_settings.update_settings(params)

    respond_to do |format|
      format.json { render :json => @project_settings }
    end
  end

  def addrun
    @jmeter_run = JmeterRun
    @project = Project.find_by_name(params[:id])
    @project.jmeter_runs.create(:description => "created at #{Time.now} ", :jmx_source => @project.setting.jmx_file)

    if @project.save
      respond_to do |format|
        format.json { render :json => @project.jmeter_runs.last.id}
      end
    end
  end

end


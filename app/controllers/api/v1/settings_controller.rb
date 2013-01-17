class SettingsController < ApplicationController
  # GET /settings
  # GET /settings.json
  def index
    @settings ||= JmeterSetting.find_by_project_id(params[:project_id])

    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @settings }
    end
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
    @setting = JmeterSetting.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render :json => @setting }
    end
  end

  # GET /settings/new
  # GET /settings/new.json
  def new
    @setting ||= JmeterSetting.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render :json => @setting }
    end
  end

  # GET /settings/1/edit
  def edit
    @setting ||= JmeterSetting.find(params[:id])
    @project ||=  Project.find_by_param(params[:project_id])
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = JmeterSetting.new(params[:setting])

    respond_to do |format|
      if @setting.save
        format.html { redirect_to  project_setting_path(@setting, @setting.project_id),
                                   :notice => 'Setting was successfully created.' }
        format.json { render :json => @setting, :status => :created, :location => @setting }
      else
        format.html { render :action => "new" }
        format.json { render :json => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /settings/1
  # PUT /settings/1.json
  def update
    @setting = JmeterSetting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to project_setting_path(@setting, @setting.project_id), :notice => 'Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting = JmeterSetting.find(params[:id])
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to project_settings_path(@setting.project_id) }
      format.json { head :no_content }
    end
  end
end

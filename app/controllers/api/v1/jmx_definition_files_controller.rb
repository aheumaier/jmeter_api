class JmxDefinitionFilesController < ApplicationController
  # GET /jmx_definition_files
  # GET /jmx_definition_files.json
  def index
    @jmx_definition_files = JmxDefinitionFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jmx_definition_files }
    end
  end

  # GET /jmx_definition_files/1
  # GET /jmx_definition_files/1.json
  def show
    @jmx_definition_file = JmxDefinitionFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jmx_definition_file }
    end
  end

  # GET /jmx_definition_files/new
  # GET /jmx_definition_files/new.json
  def new
    @jmx_definition_file = JmxDefinitionFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jmx_definition_file }
    end
  end

  # GET /jmx_definition_files/1/edit
  def edit
    @jmx_definition_file = JmxDefinitionFile.find(params[:id])
  end

  # POST /jmx_definition_files
  # POST /jmx_definition_files.json
  def create
    @jmx_definition_file = JmxDefinitionFile.new(params[:jmx_definition_file])

    respond_to do |format|
      if @jmx_definition_file.save
        format.html { redirect_to @jmx_definition_file, notice: 'Jmx definition file was successfully created.' }
        format.json { render json: @jmx_definition_file, status: :created, location: @jmx_definition_file }
      else
        format.html { render action: "new" }
        format.json { render json: @jmx_definition_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jmx_definition_files/1
  # PUT /jmx_definition_files/1.json
  def update
    @jmx_definition_file = JmxDefinitionFile.find(params[:id])

    respond_to do |format|
      if @jmx_definition_file.update_attributes(params[:jmx_definition_file])
        format.html { redirect_to @jmx_definition_file, notice: 'Jmx definition file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jmx_definition_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jmx_definition_files/1
  # DELETE /jmx_definition_files/1.json
  def destroy
    @jmx_definition_file = JmxDefinitionFile.find(params[:id])
    @jmx_definition_file.destroy

    respond_to do |format|
      format.html { redirect_to jmx_definition_files_url }
      format.json { head :no_content }
    end
  end
end

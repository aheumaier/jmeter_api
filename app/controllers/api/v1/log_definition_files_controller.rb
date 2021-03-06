class LogDefinitionFilesController < ApplicationController
  # GET /log_definition_files
  # GET /log_definition_files.json
  def index
    @log_definition_files = LogDefinitionFile.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @log_definition_files }
    end
  end

  # GET /log_definition_files/1
  # GET /log_definition_files/1.json
  def show
    @log_definition_file = LogDefinitionFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @log_definition_file }
    end
  end

  # GET /log_definition_files/new
  # GET /log_definition_files/new.json
  def new
    @log_definition_file = LogDefinitionFile.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @log_definition_file }
    end
  end

  # GET /log_definition_files/1/edit
  def edit
    @log_definition_file = LogDefinitionFile.find(params[:id])
  end

  # POST /log_definition_files
  # POST /log_definition_files.json
  def create
    @log_definition_file = LogDefinitionFile.new(params[:log_definition_file])

    respond_to do |format|
      if @log_definition_file.save
        format.html { redirect_to @log_definition_file, notice: 'Log definition file was successfully created.' }
        format.json { render json: @log_definition_file, status: :created, location: @log_definition_file }
      else
        format.html { render action: "new" }
        format.json { render json: @log_definition_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /log_definition_files/1
  # PUT /log_definition_files/1.json
  def update
    @log_definition_file = LogDefinitionFile.find(params[:id])

    respond_to do |format|
      if @log_definition_file.update_attributes(params[:log_definition_file])
        format.html { redirect_to @log_definition_file, notice: 'Log definition file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @log_definition_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_definition_files/1
  # DELETE /log_definition_files/1.json
  def destroy
    @log_definition_file = LogDefinitionFile.find(params[:id])
    @log_definition_file.destroy

    respond_to do |format|
      format.html { redirect_to log_definition_files_url }
      format.json { head :no_content }
    end
  end
end

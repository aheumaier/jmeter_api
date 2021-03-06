class LogDefinitionFilesController < ApplicationController
  # GET /log_definition_files
  def index
    @log_definition_files = LogDefinitionFile.all

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # GET /log_definition_files/1
  def show
    @log_definition_file = LogDefinitionFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
    end
  end

  # GET /log_definition_files/new
  def new
    @log_definition_file = LogDefinitionFile.new

    respond_to do |format|
      format.html # new.html.haml
    end
  end

  # GET /log_definition_files/1/edit
  def edit
    @log_definition_file = LogDefinitionFile.find(params[:id])
  end

  # POST /log_definition_files
  def create
    @log_definition_file = LogDefinitionFile.new(params[:log_definition_file])

    respond_to do |format|
      if @log_definition_file.save
        format.html { redirect_to definition_files_index_path, notice: 'AccessLog was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /log_definition_files/1
  def update
    @log_definition_file = LogDefinitionFile.find(params[:id])
    respond_to do |format|
      if @log_definition_file.update_attributes(params[:log_definition_file])
        format.html { redirect_to @log_definition_file, notice: 'Log definition file was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /log_definition_files/1
  def destroy
    @log_definition_file = LogDefinitionFile.find(params[:id])
    @log_definition_file.destroy

    respond_to do |format|
      format.html { redirect_to log_definition_files_url }
    end
  end
end

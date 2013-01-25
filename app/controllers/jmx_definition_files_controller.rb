class JmxDefinitionFilesController < ApplicationController
  # GET /jmx_definition_files
  def index
    @jmx_definition_files = JmxDefinitionFile.all

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # GET /jmx_definition_files/1
  def show
    @jmx_definition_file = JmxDefinitionFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
    end
  end

  # GET /jmx_definition_files/new
  def new
    @jmx_definition_file = JmxDefinitionFile.new

    respond_to do |format|
      format.html # new.html.haml
    end
  end

  # GET /jmx_definition_files/1/edit
  def edit
    @jmx_definition_file = JmxDefinitionFile.find(params[:id])
  end

  # POST /jmx_definition_files
  def create
    @jmx_definition_file = JmxDefinitionFile.new(params[:jmx_definition_file])

    respond_to do |format|
      if @jmx_definition_file.save
        format.html { redirect_to definition_files_index_path, notice: 'Jmx definition file was successfully created.' }
      else
        format.html { render action: "new" }

      end
    end
  end

  # PUT /jmx_definition_files/1
  def update
    @jmx_definition_file = JmxDefinitionFile.find(params[:id])

    respond_to do |format|
      if @jmx_definition_file.update_attributes(params[:jmx_definition_file])
        format.html { redirect_to definition_files_index_path, notice: 'Jmx definition file was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /jmx_definition_files/1
  def destroy
    @jmx_definition_file = JmxDefinitionFile.find(params[:id])
    @jmx_definition_file.destroy

    respond_to do |format|
      format.html { redirect_to definition_files_index_path }
    end
  end

  # GET /jmx_definition_files/1/set_as_default
  def set_as_default()

    JmxDefinitionFile.all.each do |jdf|
      #if jdf.save!
      puts jdf
        jdf.default_template = false
        jdf.save!
      #end
    end

    @jmx_definition_file = JmxDefinitionFile.find(params[:id])
    @jmx_definition_file.set_as_default

    respond_to do |format|
      format.html { redirect_to definition_files_index_path }
    end

  end

end

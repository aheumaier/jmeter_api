class DefinitionFilesController < ApplicationController
  def index
    @jmx_definition_files = JmxDefinitionFile.all
    @log_definition_files = LogDefinitionFile.all
  end
end

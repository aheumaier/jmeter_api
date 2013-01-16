class LogDefinitionFile < ActiveRecord::Base
  attr_accessible :df_name, :df_type, :df_path, :df_file_dir, :df
  mount_uploader :df, DefinitionFileUploader

  belongs_to :jmeter_run, :touch => true

  before_validation :set_metadata

  def set_metadata
    self.df_type = 'jmx'
    self.df_path = self.df.path
    #self.df_name = self.df.file.filename
  end

end

class LogDefinitionFile < ActiveRecord::Base
  attr_accessible :df_name, :df_type, :df_path, :df_file_dir, :df
  mount_uploader :df, DefinitionFileUploader

  has_many :jmeter_runs, :dependent => :destroy
  accepts_nested_attributes_for :jmeter_runs

  before_validation :set_metadata

  def set_metadata
    self.df_type = 'access_log'
    self.df_path = self.df.path
    self.df_name = self.df.file.filename
  end

end

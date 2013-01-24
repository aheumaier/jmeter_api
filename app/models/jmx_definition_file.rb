class JmxDefinitionFile < ActiveRecord::Base
  attr_accessible :df_name, :df_type, :df_path, :df_file_dir, :df, :default_template
  mount_uploader :df, DefinitionFileUploader

  has_many :jmeter_runs, :dependent => :destroy
  accepts_nested_attributes_for :jmeter_runs

  before_validation :set_metadata

  def set_metadata
    self.df_type = 'jmx'
    self.df_path = self.df.path
    self.df_name = self.df.file.filename
  end

  def is_default?
    return self.default_template
  end

end

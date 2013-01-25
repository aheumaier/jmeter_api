class JmxDefinitionFile < ActiveRecord::Base
  attr_accessible :df_name, :df_type, :df_path, :df_file_dir, :df, :default_template
  mount_uploader :df, DefinitionFileUploader

  has_many :jmeter_runs, :dependent => :destroy
  accepts_nested_attributes_for :jmeter_runs

  validates :default_template, :uniqueness => true
  before_validation :set_metadata

  def set_metadata
    self.df_type = 'jmx'
    self.df_path = self.df.path
    self.df_name = self.df.file.filename
  end

  def self.defaults?
    if JmxDefinitionFile.where(:default_template => true).count == 0
      return false
    else
      return true
    end
  end

  def self.clear_default_template
    JmxDefinitionFile.where(:default_template => true).each do |default|
      default.update_attribute(:default_template, false)
    end
  end

  def set_as_default
    JmxDefinitionFile.clear_default_template
    self.default_template=(true)
    self.save!
  end

end

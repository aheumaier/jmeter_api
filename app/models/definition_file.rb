class DefinitionFile < ActiveRecord::Base
  attr_accessible :df_name, :df_type, :df_path, :df_file_dir, :df

  mount_uploader :df, DefinitionFileUploader

end

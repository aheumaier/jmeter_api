class AddDefinitionFileAtributes < ActiveRecord::Migration
  def up
    add_column :definition_files, :df_name, :string
    add_column :definition_files, :df_type, :string
    add_column :definition_files, :df_path, :string
    add_column :definition_files, :df_file_dir, :string
  end

  def down
  end
end

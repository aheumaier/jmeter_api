class CreateJmxDefinitionFiles < ActiveRecord::Migration
  def change
    create_table :jmx_definition_files do |t|
      t.integer :jmeter_run_id
      t.timestamps
      t.string :df_name
      t.string :df_type
      t.string :df_path
      t.string :df_file_dir
      t.string :df
    end
  end
end

class AddFileToDefinitionfile < ActiveRecord::Migration
  def change
    add_column :definition_files, :df, :string
  end
end

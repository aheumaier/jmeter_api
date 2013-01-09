class CreateLogDefinitionFiles < ActiveRecord::Migration
  def change
    create_table :log_definition_files do |t|

      t.timestamps
    end
  end
end

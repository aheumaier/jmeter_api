class CreateJmxDefinitionFiles < ActiveRecord::Migration
  def change
    create_table :jmx_definition_files do |t|

      t.timestamps
    end
  end
end

class CreateDefinitionFiles < ActiveRecord::Migration
  def change
    create_table :definition_files do |t|

      t.timestamps
    end
  end
end

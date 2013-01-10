class AddDfAttributes < ActiveRecord::Migration
  def up
    change_table :definition_files do |t|
      t.integer :jmeter_run_id
    end
    change_table :jmx_definition_files do |t|
      t.integer :jmeter_run_id
    end
    change_table :log_definition_files do |t|
      t.integer :jmeter_run_id
    end
  end

  def down
  end
end

class AddStdout < ActiveRecord::Migration
  def up
    change_table :jmeter_runs do |t|
      t.string :stdout, :default => false
    end
  end
  def down
    remove_column :stdout
  end
end

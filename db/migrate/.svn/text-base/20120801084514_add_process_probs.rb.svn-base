class AddProcessProbs < ActiveRecord::Migration
  def up
    change_table :jmeter_runs do |t|
      t.string :stderror, :default => false
      t.integer :jmeter_pid, :default => false
    end
  end
 
  def down
    remove_column :stderror, :jmeter_pid
  end
end

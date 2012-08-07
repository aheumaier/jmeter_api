class AddWorkerLock < ActiveRecord::Migration
def up
    change_table :jmeter_runs do |t|
      t.boolean :locked, :default => false
    end
  end

  def down
    remove_column :locked
  end
end

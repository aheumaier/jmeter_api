class CreateJmeterRuns < ActiveRecord::Migration
  def change
    create_table :jmeter_runs do |t|
      t.integer :project_id
      t.string :description
      t.string :jmx_source
      t.string :state
      t.string :stderror, :default => false
      t.string :stdout, :default => false
      t.integer :jmeter_pid, :default => false
      t.boolean :locked, :default => false

      t.timestamps
    end
  end
end

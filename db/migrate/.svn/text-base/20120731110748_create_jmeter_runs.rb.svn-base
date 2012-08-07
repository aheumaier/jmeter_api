class CreateJmeterRuns < ActiveRecord::Migration
  def change
    create_table :jmeter_runs do |t|
      t.integer :project_id
      t.string :description
      t.string :jmx_source
      t.string :state

      t.timestamps
    end
  end
end

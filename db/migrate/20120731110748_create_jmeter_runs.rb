class CreateJmeterRuns < ActiveRecord::Migration
  def change
    create_table :jmeter_runs do |t|
      t.integer :project_id
      t.string :description, :default => 'CHANGE ME - default jmeter run description.'
      t.string :state
      t.string :stderror, :default => nil
      t.string :stdout, :default => nil
      t.integer :jmeter_pid, :default => false
      t.boolean :locked, :default => false
      t.string :jmeter_accesslog, :default => nil
      t.integer :jmeter_counter, :default => 1
      t.integer :jmeter_period, :default => 3600
      t.integer :jmeter_threads, :default => 20
      t.integer :jmeter_troughput, :default => 600
      t.string :jmx_file, :default => nil
      t.string :jtl_file, :default => nil
      t.string :remote_server, :default => nil
      t.string :ext_opts, :default => nil
      t.integer :log_definition_file_id, :default => nil
      t.integer :jmx_definition_file_id, :default => nil
      t.timestamps
    end
  end
end

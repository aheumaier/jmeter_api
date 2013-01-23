class CreateJmeterRuns < ActiveRecord::Migration
  def change
    create_table :jmeter_runs do |t|
      t.integer  :project_id
      t.string   :description, :default => 'CHANGE ME - default jmeter run description.'
      t.string   :state
      t.string   :stderror, :default => nil
      t.string   :stdout, :default => nil
      t.integer  :jmeter_pid, :default => false
      t.boolean  :locked, :default => false
      t.string   :jprop_accesslog, :default => nil
      t.integer  :jprop_counter, :default => 1
      t.integer  :jprop_period, :default => 3600
      t.integer  :jprop_threads, :default => 20
      t.integer  :jprop_throughput, :default => 600
      t.string   :jprop_jmx, :default => nil
      t.string   :jprop_jtl, :default => nil
      t.string   :jprop_remote_server, :default => nil
      t.string   :ext_opts, :default => nil
      t.integer  :log_definition_file_id, :default => nil
      t.integer  :jmx_definition_file_id, :default => nil
      t.timestamps
    end
  end
end

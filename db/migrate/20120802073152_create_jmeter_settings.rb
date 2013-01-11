class CreateJmeterSettings < ActiveRecord::Migration
  def change
    create_table :jmeter_settings do |t|
      t.string :jmx_file
      t.string :jtl_file
      t.integer :jmeter_threads
      t.string :remote_server
      t.integer :jmeter_counter
      t.string :jmeter_troughput
      t.integer :jmeter_period
      t.string :jmeter_accesslog
      t.string :jtl_path, :string
      t.integer :jmeter_run_id
      t.text :ext_opts

      t.timestamps
    end
  end
end

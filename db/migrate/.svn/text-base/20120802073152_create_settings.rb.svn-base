class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :jmx_file
      t.string :jtl_file
      t.integer :jmeter_threads
      t.string :remote_server
      t.integer :jmeter_counter
      t.string :jmeter_troughput
      t.integer :jmeter_period
      t.string :jmeter_accesslog

      t.timestamps
    end
  end
end

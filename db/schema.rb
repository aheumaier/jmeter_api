# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130109144057) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "jmeter_runs", :force => true do |t|
    t.integer  "project_id"
    t.string   "description"
    t.string   "jmx_source"
    t.string   "state"
    t.string   "stderror",    :default => "0"
    t.string   "stdout",      :default => "0"
    t.integer  "jmeter_pid",  :default => 0
    t.boolean  "locked",      :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "jmeter_settings", :force => true do |t|
    t.string   "jmx_file"
    t.string   "jtl_file"
    t.integer  "jmeter_threads"
    t.string   "remote_server"
    t.integer  "jmeter_counter"
    t.string   "jmeter_troughput"
    t.integer  "jmeter_period"
    t.string   "jmeter_accesslog"
    t.string   "jtl_path"
    t.string   "string"
    t.integer  "jmeter_run_id"
    t.text     "ext_opts"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "jmeter_workers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jmx_definition_files", :force => true do |t|
    t.integer  "jmeter_run_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "df_name"
    t.string   "df_type"
    t.string   "df_path"
    t.string   "df_file_dir"
    t.string   "df"
  end

  create_table "log_definition_files", :force => true do |t|
    t.integer  "jmeter_run_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "df_name"
    t.string   "df_type"
    t.string   "df_path"
    t.string   "df_file_dir"
    t.string   "df"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "environment"
    t.string   "reports_home"
    t.string   "platform"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end

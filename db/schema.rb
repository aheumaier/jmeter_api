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
    t.string   "description",            :default => "CHANGE ME - default jmeter run description."
    t.string   "state"
    t.string   "stderror"
    t.string   "stdout"
    t.integer  "jmeter_pid",             :default => 0
    t.boolean  "locked",                 :default => false
    t.string   "jprop_accesslog"
    t.integer  "jprop_counter",          :default => 1
    t.integer  "jprop_period",           :default => 3600
    t.integer  "jprop_threads",          :default => 20
    t.integer  "jprop_throughput",       :default => 600
    t.string   "jprop_jmx"
    t.string   "jprop_jtl"
    t.string   "jprop_remote_server"
    t.string   "ext_opts"
    t.integer  "log_definition_file_id"
    t.integer  "jmx_definition_file_id"
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
  end

  create_table "jmeter_workers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jmx_definition_files", :force => true do |t|
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "df_name"
    t.string   "df_type"
    t.string   "df_path"
    t.string   "df_file_dir"
    t.string   "df"
    t.boolean  "default_template", :default => false
  end

  create_table "log_definition_files", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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

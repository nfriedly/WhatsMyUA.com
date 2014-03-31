# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101009180726) do

  create_table "part_overrides", :force => true do |t|
    t.integer  "part_id"
    t.integer  "override_part_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ua_parts", :force => true do |t|
    t.string  "key",                              :null => false
    t.string  "description"
    t.string  "part_type"
    t.boolean "named_version", :default => false, :null => false
    t.string  "split_on"
    t.string  "split_before"
    t.string  "version_after"
  end

  create_table "user_agents", :force => true do |t|
    t.string   "user_agent"
    t.integer  "hits",       :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_agents", ["user_agent"], :name => "user_agent", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "crypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

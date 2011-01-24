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

ActiveRecord::Schema.define(:version => 20110124214046) do

  create_table "categories", :force => true do |t|
    t.text     "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_projects", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "project_id"
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media", :force => true do |t|
    t.string   "label"
    t.integer  "project_id"
    t.integer  "statusupdate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.string   "type"
  end

  create_table "notifications", :force => true do |t|
    t.text     "content"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "project_id"
    t.boolean  "isNew"
    t.string   "html_tmpl_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.string   "link"
    t.text     "description"
    t.boolean  "isInternal"
    t.boolean  "isPublic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currentstage"
    t.integer  "cover_id"
  end

  create_table "roles", :force => true do |t|
    t.string  "role"
    t.integer "project_id"
    t.integer "user_id"
    t.string  "job"
  end

  create_table "stages", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statusupdates", :force => true do |t|
    t.string   "content"
    t.boolean  "isPublic"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "html_tmpl_key"
  end

  create_table "texttemplates", :force => true do |t|
    t.string   "key"
    t.text     "text",       :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "telephone"
    t.string   "web"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

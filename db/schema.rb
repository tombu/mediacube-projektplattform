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

ActiveRecord::Schema.define(:version => 20101227185408) do

  create_table "categories", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_projects", :force => true do |t|
    t.integer "project_id"
    t.integer "category_id"
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ldap_users", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ldap_users", ["email"], :name => "index_ldap_users_on_email", :unique => true
  add_index "ldap_users", ["reset_password_token"], :name => "index_ldap_users_on_reset_password_token", :unique => true

  create_table "medias", :force => true do |t|
    t.string   "label"
    t.string   "link"
    t.integer  "project_id"
    t.integer  "statusupdate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.string   "link"
    t.text     "description"
    t.integer  "picture"
    t.integer  "currentStage"
    t.boolean  "isInternal"
    t.boolean  "isPublic"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects_users", :force => true do |t|
    t.string  "role"
    t.integer "project_id"
    t.integer "user_id"
    t.integer "job_id"
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
    t.text     "content"
    t.boolean  "isPublic"
    t.integer  "template_message_id"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_messages", :force => true do |t|
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "mail"
    t.string   "telephone"
    t.string   "password"
    t.string   "web"
    t.string   "avatar"
    t.string   "fhname"
    t.string   "course"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

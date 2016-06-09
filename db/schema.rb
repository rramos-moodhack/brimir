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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160513100633) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "attachable_id",     limit: 4
    t.string   "attachable_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.string   "content_id",        limit: 255
  end

  add_index "attachments", ["attachable_id"], name: "index_attachments_on_attachable_id", using: :btree

  create_table "email_addresses", force: :cascade do |t|
    t.string   "email",              limit: 255
    t.boolean  "default",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "verification_token", limit: 255
    t.string   "name",               limit: 255
  end

  create_table "identities", force: :cascade do |t|
    t.integer "user_id",  limit: 4
    t.string  "uid",      limit: 255
    t.string  "provider", limit: 255
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "labelings", force: :cascade do |t|
    t.integer  "label_id",       limit: 4
    t.integer  "labelable_id",   limit: 4
    t.string   "labelable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labelings", ["label_id", "labelable_id", "labelable_type"], name: "unique_labeling_label", unique: true, using: :btree
  add_index "labelings", ["label_id"], name: "index_labelings_on_label_id", using: :btree
  add_index "labelings", ["labelable_type", "labelable_id"], name: "index_labelings_on_labelable_type_and_labelable_id", using: :btree

  create_table "labels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color",      limit: 255
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "notifiable_id",   limit: 4
    t.string   "notifiable_type", limit: 255
    t.integer  "user_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["notifiable_id", "notifiable_type", "user_id"], name: "unique_notification", unique: true, using: :btree
  add_index "notifications", ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.text     "content",                  limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_id",                limit: 4
    t.integer  "user_id",                  limit: 4
    t.string   "message_id",               limit: 255
    t.string   "content_type",             limit: 255,        default: "html"
    t.boolean  "draft",                                       default: false,  null: false
    t.string   "raw_message_file_name",    limit: 255
    t.string   "raw_message_content_type", limit: 255
    t.integer  "raw_message_file_size",    limit: 4
    t.datetime "raw_message_updated_at"
    t.boolean  "internal",                                    default: false,  null: false
  end

  add_index "replies", ["message_id"], name: "index_replies_on_message_id", using: :btree
  add_index "replies", ["ticket_id"], name: "index_replies_on_ticket_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "rules", force: :cascade do |t|
    t.string   "filter_field",     limit: 255
    t.integer  "filter_operation", limit: 4,   default: 0, null: false
    t.string   "filter_value",     limit: 255
    t.integer  "action_operation", limit: 4,   default: 0, null: false
    t.string   "action_value",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "status_changes", force: :cascade do |t|
    t.integer  "ticket_id",  limit: 4
    t.integer  "status",     limit: 4, default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "status_changes", ["ticket_id"], name: "index_status_changes_on_ticket_id", using: :btree

  create_table "tenants", force: :cascade do |t|
    t.string   "domain",                              limit: 255
    t.string   "from",                                limit: 255
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.string   "default_time_zone",                   limit: 255, default: "Amsterdam"
    t.boolean  "ignore_user_agent_locale",                        default: false,       null: false
    t.string   "default_locale",                      limit: 255, default: "en"
    t.boolean  "share_drafts",                                    default: false
    t.boolean  "first_reply_ignores_notified_agents",             default: false,       null: false
  end

  add_index "tenants", ["domain"], name: "index_tenants_on_domain", unique: true, using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "subject",                  limit: 255
    t.text     "content",                  limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignee_id",              limit: 4
    t.string   "message_id",               limit: 255
    t.integer  "user_id",                  limit: 4
    t.string   "content_type",             limit: 255,        default: "html"
    t.integer  "status",                   limit: 4,          default: 0,      null: false
    t.integer  "priority",                 limit: 4,          default: 0,      null: false
    t.integer  "to_email_address_id",      limit: 4
    t.integer  "locked_by_id",             limit: 4
    t.datetime "locked_at"
    t.string   "raw_message_file_name",    limit: 255
    t.string   "raw_message_content_type", limit: 255
    t.integer  "raw_message_file_size",    limit: 4
    t.datetime "raw_message_updated_at"
  end

  add_index "tickets", ["assignee_id"], name: "index_tickets_on_assignee_id", using: :btree
  add_index "tickets", ["locked_by_id"], name: "index_tickets_on_locked_by_id", using: :btree
  add_index "tickets", ["message_id"], name: "index_tickets_on_message_id", using: :btree
  add_index "tickets", ["priority"], name: "index_tickets_on_priority", using: :btree
  add_index "tickets", ["status"], name: "index_tickets_on_status", using: :btree
  add_index "tickets", ["to_email_address_id"], name: "index_tickets_on_to_email_address_id", using: :btree
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "agent",                                default: false, null: false
    t.text     "signature",              limit: 65535
    t.boolean  "notify",                               default: true
    t.string   "authentication_token",   limit: 255
    t.string   "time_zone",              limit: 255
    t.integer  "per_page",               limit: 4,     default: 30,    null: false
    t.string   "locale",                 limit: 255
    t.boolean  "prefer_plain_text",                    default: false, null: false
    t.boolean  "include_quote_in_reply",               default: true,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "identities", "users"
  add_foreign_key "labelings", "labels"
  add_foreign_key "notifications", "users"
  add_foreign_key "replies", "tickets"
  add_foreign_key "replies", "users"
  add_foreign_key "status_changes", "tickets"
  add_foreign_key "tickets", "email_addresses", column: "to_email_address_id"
  add_foreign_key "tickets", "users"
  add_foreign_key "tickets", "users", column: "assignee_id"
  add_foreign_key "tickets", "users", column: "locked_by_id"
end

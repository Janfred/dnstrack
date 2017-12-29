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

ActiveRecord::Schema.define(version: 20171229103321) do

  create_table "records", force: :cascade do |t|
    t.integer "zone_id"
    t.string "name"
    t.integer "ttl"
    t.string "rrtype"
    t.integer "priority"
    t.string "target"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "committed"
    t.index ["zone_id"], name: "index_records_on_zone_id"
  end

  create_table "soa_records", force: :cascade do |t|
    t.integer "zone_id"
    t.string "primary_ns"
    t.string "contact"
    t.integer "serial"
    t.integer "refresh"
    t.integer "retry"
    t.integer "expire"
    t.integer "ttl"
    t.string "serial_schema"
    t.boolean "committed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zone_id"], name: "index_soa_records_on_zone_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 1073741823
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "zones", force: :cascade do |t|
    t.string "fqdn"
    t.boolean "psedo_zone"
    t.string "description"
    t.integer "parent_zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_zone_id"], name: "index_zones_on_parent_zone_id"
  end

end

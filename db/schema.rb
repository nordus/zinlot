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

ActiveRecord::Schema.define(version: 20130601014653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "alerts", force: true do |t|
    t.boolean  "checked",                                        default: false
    t.string   "device_id"
    t.integer  "driver_id"
    t.integer  "update_time"
    t.integer  "trip_start_at"
    t.decimal  "latitude",             precision: 15, scale: 10
    t.decimal  "longitude",            precision: 15, scale: 10
    t.integer  "event_type"
    t.string   "geofence_id"
    t.integer  "time_inside_geofence"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  create_table "device_histories", force: true do |t|
    t.string   "device_id"
    t.string   "obd_vin"
    t.integer  "power_on_at"
    t.integer  "time_gap"
    t.float    "odometer"
    t.float    "miles_gap"
    t.float    "gps_miles_gap"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "dtc_codes"
  end

  create_table "historical_trips", force: true do |t|
    t.integer  "status",              default: 0
    t.string   "device_id"
    t.integer  "key_fob_id",          default: 0
    t.integer  "start_at",            default: 0
    t.integer  "end_at",              default: 0
    t.integer  "duration",            default: 0
    t.float    "miles",               default: 0.0
    t.integer  "num_hard_brake",      default: 0
    t.integer  "num_hard_accel",      default: 0
    t.integer  "num_speed_event",     default: 0
    t.integer  "num_rpm_event",       default: 0
    t.float    "ending_mileage",      default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.float    "highest_speed",       default: 0.0
    t.integer  "idle_seconds",        default: 0
    t.string   "time_zone"
    t.date     "end_date"
    t.integer  "qos_flags",           default: 0
    t.integer  "num_corner_l"
    t.integer  "num_corner_r"
    t.integer  "num_very_hard_brake", default: 0
    t.integer  "num_very_hard_accel", default: 0
    t.integer  "num_hard_corner_l"
    t.integer  "num_hard_corner_r"
    t.float    "fuel_gal_start"
    t.float    "fuel_gal_end"
  end

  create_table "vehicles", force: true do |t|
    t.string   "vin"
    t.datetime "acquired_date"
    t.datetime "sold_date"
    t.string   "vehicle_type"
    t.string   "vehicle_usage"
    t.string   "vehicle_status"
    t.string   "vehicle_location"
    t.string   "car_color"
    t.integer  "vehicle_mileage"
    t.decimal  "garage_loc_lat",   precision: 15, scale: 10
    t.decimal  "garage_loc_long",  precision: 15, scale: 10
    t.integer  "car_id"
    t.datetime "ship_start"
    t.datetime "ship_end"
  end

end

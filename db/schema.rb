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

ActiveRecord::Schema.define(version: 20130830051148) do

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

  create_table "cars", force: true do |t|
    t.string "year"
    t.string "make"
    t.string "model"
  end

  create_table "clients", force: true do |t|
    t.string    "email",                                default: "", null: false
    t.string    "encrypted_password",                   default: "", null: false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at", precision: 6
    t.timestamp "remember_created_at",    precision: 6
    t.integer   "sign_in_count",                        default: 0
    t.timestamp "current_sign_in_at",     precision: 6
    t.timestamp "last_sign_in_at",        precision: 6
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",             precision: 6,              null: false
    t.timestamp "updated_at",             precision: 6,              null: false
  end

  add_index "clients", ["email"], name: "index_clients_on_email", unique: true, using: :btree
  add_index "clients", ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree

  create_table "cms_blocks", force: true do |t|
    t.integer   "page_id",                  null: false
    t.string    "identifier",               null: false
    t.text      "content"
    t.timestamp "created_at", precision: 6, null: false
    t.timestamp "updated_at", precision: 6, null: false
  end

  add_index "cms_blocks", ["page_id", "identifier"], name: "index_cms_blocks_on_page_id_and_identifier", using: :btree

  create_table "cms_categories", force: true do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_categorized_type_and_label", unique: true, using: :btree

  create_table "cms_categorizations", force: true do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "cms_files", force: true do |t|
    t.integer   "site_id",                                                  null: false
    t.integer   "block_id"
    t.string    "label",                                                    null: false
    t.string    "file_file_name",                                           null: false
    t.string    "file_content_type",                                        null: false
    t.integer   "file_file_size",                                           null: false
    t.string    "description",       limit: 2048
    t.integer   "position",                                     default: 0, null: false
    t.timestamp "created_at",                     precision: 6,             null: false
    t.timestamp "updated_at",                     precision: 6,             null: false
  end

  add_index "cms_files", ["site_id", "block_id"], name: "index_cms_files_on_site_id_and_block_id", using: :btree
  add_index "cms_files", ["site_id", "file_file_name"], name: "index_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "cms_files", ["site_id", "label"], name: "index_cms_files_on_site_id_and_label", using: :btree
  add_index "cms_files", ["site_id", "position"], name: "index_cms_files_on_site_id_and_position", using: :btree

  create_table "cms_layouts", force: true do |t|
    t.integer   "site_id",                                  null: false
    t.integer   "parent_id"
    t.string    "app_layout"
    t.string    "label",                                    null: false
    t.string    "identifier",                               null: false
    t.text      "content"
    t.text      "css"
    t.text      "js"
    t.integer   "position",                 default: 0,     null: false
    t.boolean   "is_shared",                default: false, null: false
    t.timestamp "created_at", precision: 6,                 null: false
    t.timestamp "updated_at", precision: 6,                 null: false
  end

  add_index "cms_layouts", ["parent_id", "position"], name: "index_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "cms_layouts", ["site_id", "identifier"], name: "index_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "cms_pages", force: true do |t|
    t.integer   "site_id",                                      null: false
    t.integer   "layout_id"
    t.integer   "parent_id"
    t.integer   "target_page_id"
    t.string    "label",                                        null: false
    t.string    "slug"
    t.string    "full_path",                                    null: false
    t.text      "content"
    t.integer   "position",                     default: 0,     null: false
    t.integer   "children_count",               default: 0,     null: false
    t.boolean   "is_published",                 default: true,  null: false
    t.boolean   "is_shared",                    default: false, null: false
    t.timestamp "created_at",     precision: 6,                 null: false
    t.timestamp "updated_at",     precision: 6,                 null: false
  end

  add_index "cms_pages", ["parent_id", "position"], name: "index_cms_pages_on_parent_id_and_position", using: :btree
  add_index "cms_pages", ["site_id", "full_path"], name: "index_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "cms_revisions", force: true do |t|
    t.string    "record_type",               null: false
    t.integer   "record_id",                 null: false
    t.text      "data"
    t.timestamp "created_at",  precision: 6
  end

  add_index "cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_record_type_and_record_id_and_created_at", using: :btree

  create_table "cms_sites", force: true do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "cms_sites", ["hostname"], name: "index_cms_sites_on_hostname", using: :btree
  add_index "cms_sites", ["is_mirrored"], name: "index_cms_sites_on_is_mirrored", using: :btree

  create_table "cms_snippets", force: true do |t|
    t.integer   "site_id",                                  null: false
    t.string    "label",                                    null: false
    t.string    "identifier",                               null: false
    t.text      "content"
    t.integer   "position",                 default: 0,     null: false
    t.boolean   "is_shared",                default: false, null: false
    t.timestamp "created_at", precision: 6,                 null: false
    t.timestamp "updated_at", precision: 6,                 null: false
  end

  add_index "cms_snippets", ["site_id", "identifier"], name: "index_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "cms_snippets", ["site_id", "position"], name: "index_cms_snippets_on_site_id_and_position", using: :btree

  create_table "dealer_companies", force: true do |t|
    t.string   "name"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "address"
    t.decimal  "latitude",   precision: 15, scale: 10
    t.decimal  "longitude",  precision: 15, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dealer_groups", force: true do |t|
    t.string   "name"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "address"
    t.string   "subdomain"
    t.decimal  "latitude",   precision: 15, scale: 10
    t.decimal  "longitude",  precision: 15, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dealer_lots", force: true do |t|
    t.string   "name"
    t.integer  "dealer_company_id"
    t.string   "region"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "address"
    t.decimal  "latitude",          precision: 15, scale: 10
    t.decimal  "longitude",         precision: 15, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "has_dtc"
    t.boolean  "has_low_batt"
    t.float    "vbatt"
  end

  create_table "devices", force: true do |t|
    t.integer  "type_id"
    t.string   "imei"
    t.string   "msisdn"
    t.string   "sim_status"
    t.integer  "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "latest_history_id"
    t.integer  "vehicle_id"
    t.boolean  "has_open_issue"
    t.boolean  "has_dtc"
    t.boolean  "has_low_batt"
  end

  create_table "drivers", force: true do |t|
    t.string    "email",                                default: "", null: false
    t.string    "encrypted_password",                   default: "", null: false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at", precision: 6
    t.timestamp "remember_created_at",    precision: 6
    t.integer   "sign_in_count",                        default: 0
    t.timestamp "current_sign_in_at",     precision: 6
    t.timestamp "last_sign_in_at",        precision: 6
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",             precision: 6,              null: false
    t.timestamp "updated_at",             precision: 6,              null: false
  end

  add_index "drivers", ["email"], name: "index_drivers_on_email", unique: true, using: :btree
  add_index "drivers", ["reset_password_token"], name: "index_drivers_on_reset_password_token", unique: true, using: :btree

  create_table "enterprises", force: true do |t|
    t.string    "email",                                default: "", null: false
    t.string    "encrypted_password",                   default: "", null: false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at", precision: 6
    t.timestamp "remember_created_at",    precision: 6
    t.integer   "sign_in_count",                        default: 0
    t.timestamp "current_sign_in_at",     precision: 6
    t.timestamp "last_sign_in_at",        precision: 6
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",             precision: 6,              null: false
    t.timestamp "updated_at",             precision: 6,              null: false
  end

  add_index "enterprises", ["email"], name: "index_enterprises_on_email", unique: true, using: :btree
  add_index "enterprises", ["reset_password_token"], name: "index_enterprises_on_reset_password_token", unique: true, using: :btree

  create_table "geofence_violations", force: true do |t|
    t.string  "device_id"
    t.integer "trip_start_at"
    t.integer "geofence_id"
  end

  create_table "historical_trips", force: true do |t|
    t.integer  "status",                  default: 0
    t.string   "device_id"
    t.integer  "key_fob_id",              default: 0
    t.integer  "start_at",                default: 0
    t.integer  "end_at",                  default: 0
    t.integer  "duration",                default: 0
    t.float    "miles",                   default: 0.0
    t.integer  "num_hard_brake",          default: 0
    t.integer  "num_hard_accel",          default: 0
    t.integer  "num_speed_event",         default: 0
    t.integer  "num_rpm_event",           default: 0
    t.float    "ending_mileage",          default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.float    "highest_speed",           default: 0.0
    t.integer  "idle_seconds",            default: 0
    t.string   "time_zone"
    t.date     "end_date"
    t.integer  "qos_flags",               default: 0
    t.integer  "num_corner_l"
    t.integer  "num_corner_r"
    t.integer  "num_very_hard_brake",     default: 0
    t.integer  "num_very_hard_accel",     default: 0
    t.integer  "num_hard_corner_l"
    t.integer  "num_hard_corner_r"
    t.float    "fuel_gal_start"
    t.float    "fuel_gal_end"
    t.integer  "num_enter_geo_zone"
    t.integer  "num_exit_geo_zone"
    t.integer  "trip_number"
    t.boolean  "has_geofence_violations"
  end

  create_table "users", force: true do |t|
    t.string    "email",                                  default: "", null: false
    t.string    "encrypted_password",                     default: "", null: false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at",   precision: 6
    t.timestamp "remember_created_at",      precision: 6
    t.integer   "sign_in_count",                          default: 0
    t.timestamp "current_sign_in_at",       precision: 6
    t.timestamp "last_sign_in_at",          precision: 6
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.string    "notification_emails"
    t.string    "notification_phone_nbrs"
    t.integer   "email_notifications_mask"
    t.integer   "sms_notifications_mask"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vehicle_usages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", force: true do |t|
    t.string   "vin"
    t.datetime "acquired_date"
    t.datetime "sold_date"
    t.string   "vehicle_type"
    t.string   "vehicle_status"
    t.string   "vehicle_location"
    t.string   "car_color"
    t.integer  "vehicle_mileage"
    t.decimal  "garage_loc_lat",   precision: 15, scale: 10
    t.decimal  "garage_loc_long",  precision: 15, scale: 10
    t.integer  "car_id"
    t.datetime "ship_start"
    t.datetime "ship_end"
    t.integer  "vehicle_usage_id"
    t.integer  "dealer_lot_id"
  end

end

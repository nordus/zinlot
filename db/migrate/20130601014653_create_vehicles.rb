class CreateVehicles < ActiveRecord::Migration
  def change
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
end

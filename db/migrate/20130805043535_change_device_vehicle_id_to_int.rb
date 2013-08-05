class ChangeDeviceVehicleIdToInt < ActiveRecord::Migration
  def change
    drop_table :devices

    create_table :devices do |t|
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
    end
  end
end
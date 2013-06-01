class CreateDevices < ActiveRecord::Migration
  def change
    create_table "devices", :force => true do |t|
      t.integer  "type_id"
      t.string   "imei"
      t.string   "msisdn"
      t.string   "sim_status"
      t.integer  "activated_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
      t.integer  "latest_history_id"
    end
  end
end

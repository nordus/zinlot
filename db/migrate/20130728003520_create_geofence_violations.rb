class CreateGeofenceViolations < ActiveRecord::Migration
  def change
    create_table :geofence_violations do |t|
      t.string  :device_id
      t.integer :trip_start_at
      t.integer :geofence_id
    end
  end
end

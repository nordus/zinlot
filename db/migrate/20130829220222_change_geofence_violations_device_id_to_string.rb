class ChangeGeofenceViolationsDeviceIdToString < ActiveRecord::Migration
  def change
    change_column :geofence_violations, :device_id, :string
  end
end

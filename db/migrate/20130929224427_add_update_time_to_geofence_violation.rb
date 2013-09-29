class AddUpdateTimeToGeofenceViolation < ActiveRecord::Migration
  def change
    add_column :geofence_violations, :update_time, :integer
  end
end

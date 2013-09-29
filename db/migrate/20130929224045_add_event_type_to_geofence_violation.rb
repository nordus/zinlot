class AddEventTypeToGeofenceViolation < ActiveRecord::Migration
  def change
    add_column :geofence_violations, :event_type, :integer
  end
end

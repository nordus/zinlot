class AddHasFenceViolationsToTrips < ActiveRecord::Migration
  def change
    add_column :historical_trips, :has_geofence_violations, :boolean
  end
end

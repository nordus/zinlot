class AddGeoZoneToTrips < ActiveRecord::Migration
  def change
    add_column :historical_trips, :num_enter_geo_zone, :integer
    add_column :historical_trips, :num_exit_geo_zone, :integer
  end
end

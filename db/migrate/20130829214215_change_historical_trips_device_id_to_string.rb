class ChangeHistoricalTripsDeviceIdToString < ActiveRecord::Migration
  def change
    change_column :historical_trips, :device_id, :string
  end
end

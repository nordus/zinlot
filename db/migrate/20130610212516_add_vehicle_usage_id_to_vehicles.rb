class AddVehicleUsageIdToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :vehicle_usage_id, :integer
    remove_column :vehicles, :vehicle_usage
  end
end

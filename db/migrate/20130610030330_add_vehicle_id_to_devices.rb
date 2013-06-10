class AddVehicleIdToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :vehicle_id, :string
  end
end

class CreateVehicleUsages < ActiveRecord::Migration
  def change
    create_table :vehicle_usages do |t|
      t.string      :name
      t.timestamps
    end
  end
end

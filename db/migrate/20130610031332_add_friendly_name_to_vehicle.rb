class AddFriendlyNameToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :friendly_name, :string
  end
end

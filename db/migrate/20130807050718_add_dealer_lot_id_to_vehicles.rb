class AddDealerLotIdToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :dealer_lot_id, :integer
  end
end

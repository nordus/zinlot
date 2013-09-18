class AddDealerLotIdToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :dealer_lot_id, :integer
  end
end

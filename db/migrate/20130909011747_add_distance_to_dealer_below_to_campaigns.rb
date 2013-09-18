class AddDistanceToDealerBelowToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :distance_to_dealer_below, :integer
  end
end

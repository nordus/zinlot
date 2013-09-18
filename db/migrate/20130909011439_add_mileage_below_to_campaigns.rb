class AddMileageBelowToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :mileage_below, :integer
  end
end

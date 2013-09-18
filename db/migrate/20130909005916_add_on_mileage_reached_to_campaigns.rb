class AddOnMileageReachedToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :on_mileage_reached, :integer
  end
end

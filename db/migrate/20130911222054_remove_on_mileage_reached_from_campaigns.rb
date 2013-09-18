class RemoveOnMileageReachedFromCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :on_mileage_reached
  end
end

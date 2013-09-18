class AddMileageIntervalToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :mileage_interval, :integer
  end
end

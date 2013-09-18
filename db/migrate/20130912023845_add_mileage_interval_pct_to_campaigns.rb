class AddMileageIntervalPctToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :mileage_interval_pct, :float
  end
end

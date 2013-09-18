class RenameMileageBelowToMileageGteInCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :condition_mileage_gte
    remove_column :campaigns, :condition_device_has_dtc
    remove_column :campaigns, :condition_has_low_batt
    remove_column :campaigns, :service_notification
    rename_column :campaigns, :mileage_below, :odometer_gte
  end
end

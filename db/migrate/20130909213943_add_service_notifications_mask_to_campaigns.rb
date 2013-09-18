class AddServiceNotificationsMaskToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :service_notifications_mask, :integer
  end
end

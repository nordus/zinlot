class AddServiceNotificationToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :service_notification, :string
  end
end

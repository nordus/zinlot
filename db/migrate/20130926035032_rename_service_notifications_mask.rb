class RenameServiceNotificationsMask < ActiveRecord::Migration
  def change
    rename_column :campaigns, :service_notifications_mask, :service_issues_mask
  end
end

class RenameUserEmailNotificationSubscriptions < ActiveRecord::Migration
  def change
    rename_column :users, :email_notification_subscriptions_mask, :email_notifications_mask
  end
end

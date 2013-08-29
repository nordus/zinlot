class RenameUsersNotificationSubscriptions < ActiveRecord::Migration
  def change
    rename_column :users, :notification_subscriptions_mask, :email_notification_subscriptions_mask
  end
end

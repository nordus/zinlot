class AddNotificationSubscriptionsMaskToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification_subscriptions_mask, :integer
  end
end

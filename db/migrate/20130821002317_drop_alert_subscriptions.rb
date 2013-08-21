class DropAlertSubscriptions < ActiveRecord::Migration
  def change
    drop_table :alert_subscriptions
  end
end

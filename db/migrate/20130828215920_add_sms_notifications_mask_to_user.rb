class AddSmsNotificationsMaskToUser < ActiveRecord::Migration
  def change
    add_column :users, :sms_notifications_mask, :integer
  end
end

class AddNotificationEmailsAndPhoneNbrsToUser < ActiveRecord::Migration
  def change
    add_column :users, :notification_emails, :string
    add_column :users, :notification_phone_nbrs, :string
  end
end

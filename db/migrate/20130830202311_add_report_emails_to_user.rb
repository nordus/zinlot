class AddReportEmailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :report_emails, :string
  end
end

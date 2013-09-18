class AddEmailsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :emails, :string
  end
end

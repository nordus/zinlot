class AddIsRunningToCampaigns < ActiveRecord::Migration
  def change
    rename_column :campaigns, :is_running, :boolean
  end
end

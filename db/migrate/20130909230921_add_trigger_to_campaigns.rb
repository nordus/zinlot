class AddTriggerToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :trigger, :string
  end
end

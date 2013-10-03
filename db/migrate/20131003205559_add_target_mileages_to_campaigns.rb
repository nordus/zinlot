class AddTargetMileagesToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :target_mileages, :hstore
  end
end

class RenameDistanceToDealerBelow < ActiveRecord::Migration
  def change
    rename_column :campaigns, :distance_to_dealer_below, :distance_to_dealer
  end
end

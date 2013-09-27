class RenameOdometerGte < ActiveRecord::Migration
  def change
    rename_column :campaigns, :odometer_gte, :odometer
  end
end

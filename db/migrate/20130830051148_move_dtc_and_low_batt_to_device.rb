class MoveDtcAndLowBattToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :has_dtc, :boolean
    add_column :devices, :has_low_batt, :boolean
  end
end

class AddHasDtcAndHasLowBattToDeviceHistories < ActiveRecord::Migration
  def change
    add_column :device_histories, :has_dtc, :boolean
    add_column :device_histories, :has_low_batt, :boolean
  end
end

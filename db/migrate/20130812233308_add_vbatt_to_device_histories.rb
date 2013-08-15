class AddVbattToDeviceHistories < ActiveRecord::Migration
  def change
    add_column :device_histories, :vbatt, :float
  end
end

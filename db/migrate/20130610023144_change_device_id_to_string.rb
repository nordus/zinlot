class ChangeDeviceIdToString < ActiveRecord::Migration
  def change
    change_column :devices, :id, :string
  end
end

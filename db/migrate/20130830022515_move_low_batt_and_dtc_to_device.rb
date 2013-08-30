class MoveLowBattAndDtcToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :has_open_issue, :boolean
  end
end

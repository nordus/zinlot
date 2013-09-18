class ChangeTimeInReports < ActiveRecord::Migration
  def change
    remove_column :reports, :time
    add_column :reports, :time, :time
  end
end

class RemoveFriendlyName < ActiveRecord::Migration
  def change
    remove_column :vehicles, :friendly_name
  end
end

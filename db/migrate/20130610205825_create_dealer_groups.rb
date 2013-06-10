class CreateDealerGroups < ActiveRecord::Migration
  def change
    create_table :dealer_groups do |t|
      t.string      :name
      t.string      :country
      t.string      :state
      t.string      :city
      t.string      :address
      t.string      :subdomain
      t.decimal     :latitude, :precision => 15, :scale => 10
      t.decimal     :longitude, :precision => 15, :scale => 10
      t.timestamps
    end
  end
end

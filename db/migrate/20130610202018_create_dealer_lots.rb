class CreateDealerLots < ActiveRecord::Migration
  def change
    create_table :dealer_lots do |t|
      t.string      :name
      t.integer     :dealer_company_id
      t.string      :region
      t.string      :country
      t.string      :state
      t.string      :city
      t.string      :address
      t.decimal     :latitude, :precision => 15, :scale => 10
      t.decimal     :longitude, :precision => 15, :scale => 10
      t.timestamps
    end
  end
end

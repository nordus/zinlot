class CreateDealerCompanies < ActiveRecord::Migration
  def change
    create_table :dealer_companies do |t|
      t.string      :name
      t.string      :country
      t.string      :state
      t.string      :city
      t.string      :address
      t.decimal     :latitude, :precision => 15, :scale => 10
      t.decimal     :longitude, :precision => 15, :scale => 10
      t.string      :subdomain
      t.timestamps
    end
  end
end

class CreateCars < ActiveRecord::Migration
  def change
    create_table "cars", force: true do |t|
      t.string "year"
      t.string "make"
      t.string "model"
    end
  end
end

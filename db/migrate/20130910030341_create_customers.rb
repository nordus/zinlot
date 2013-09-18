class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :email
      t.integer :device_id
      t.string :name

      t.timestamps
    end
  end
end

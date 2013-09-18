class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :nbr_of_emails_sent
      t.string :status
      t.string :coupon_codes
      t.time :email_time
      t.string :time_zone
      t.integer :condition_mileage_gte
      t.boolean :condition_device_has_dtc
      t.boolean :condition_has_low_batt

      t.timestamps
    end
  end
end

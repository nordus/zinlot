json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :start_date, :coupon_codes, :mileage_interval_pct, :mileage_interval, :distance_to_dealer_below, :odometer_gte, :name, :dealer_lot_id, :trigger, :email_time, :service_notifications
end
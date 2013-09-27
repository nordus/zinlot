json.extract! @campaign, :coupon_codes, :dealer_lot_id, :distance_to_dealer, :email_time, :end_date, :id, :is_running, :mileage_interval, :mileage_interval_pct, :name, :odometer, :service_issues, :start_date, :trigger

if @campaign.end_date.present?
  json.end_date "#{@campaign.end_date}T00:00:00-10:00"
end

if @campaign.start_date.present?
  json.start_date "#{@campaign.start_date}T00:00:00-10:00"
end
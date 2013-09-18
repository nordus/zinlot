class Campaign < ActiveRecord::Base
  
  attr_accessible :mileage_interval, :mileage_interval_pct, :odometer_gte, :distance_to_dealer_below, :trigger, :on_mileage_reached, :dealer_lot_id, :name, :start_date, :end_date, :nbr_of_emails_sent, :status, :coupon_codes, :email_time, :time_zone, :service_notifications
  belongs_to :dealer_lot
  
  SERVICE_NOTIFICATIONS = %w[LOW_BATT DTC PREDICTIVE_SERVICE]
  
  def service_notifications=(events)
    self.service_notifications_mask = (events & SERVICE_NOTIFICATIONS).map { |e| 2**SERVICE_NOTIFICATIONS.index(e) }.sum
  end

  def service_notifications
    SERVICE_NOTIFICATIONS.reject { |e| ((service_notifications_mask || 0) & 2**SERVICE_NOTIFICATIONS.index(e)).zero? }
  end

  def email_notification_symbols
    service_notifications.map(&:to_sym)
  end
end

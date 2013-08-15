class Device < ActiveRecord::Base
  attr_protected :created_at

  belongs_to :vehicle

  has_many :historical_trips, primary_key: :imei
  has_many :alerts, primary_key: :imei

  has_one :car

  has_many :device_histories, primary_key: :imei

  def self.duration_time(duration: duration)
    time = Time.at(duration/1000).utc.strftime('%H:%M:%S')
    time.sub(/^00:/, '')
  end

  def self.miles_rounded(miles: miles); miles.round(2); end

  def latest_vbatt
    if latest_history
      latest_history[:vbatt]
    end
  end

  def battery_issue
    latest_history && latest_history[:has_low_batt]
  end

  def dtc_issue
    latest_history && latest_history[:has_dtc]
  end

  def latest_history
    if latest_history_id
      DeviceHistory.find(latest_history_id)
    end
  end

  def status
    heartbeats_in_last_24 = device_histories.where('created_at > ?', 1.day.ago).count

    if heartbeats_in_last_24 > 0
      'icon-ok'
    else
      'icon-remove'
    end
  end
end
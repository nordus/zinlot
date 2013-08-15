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
    if latest_history = device_histories.last
      latest_history[:vbatt]
    end
  end
end
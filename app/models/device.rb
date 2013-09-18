class Device < ActiveRecord::Base
  attr_protected :created_at

  belongs_to :vehicle

  has_many :historical_trips, primary_key: :imei
  has_many :alert
  has_one :car
  
  has_one :customer

  has_many :device_histories, primary_key: :imei
  
  scope :has_open_issues, -> { where(has_open_issue: true) }

  def self.duration_time(duration: duration)
    time = Time.at(duration/1000).utc.strftime('%H:%M:%S')
    time.sub(/^00:/, '')
  end

  def formatted_issues
    issues = []
    if battery_issue
      issues.push 'Low battery'
    end
    if dtc_issue
      issues.push 'DTC'
    end

    issues.join(', ')
  end

  def self.miles_rounded(miles: miles); miles.round(2); end

  def latest_vbatt
    if latest_history
      latest_history[:vbatt]
    end
  end

  def latest_dtc
    if latest_history
      latest_history[:dtc_codes]
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
      'glyphicon glyphicon-ok'
    else
      'glyphicon glyphicon-warning-sign'
    end
  end
end
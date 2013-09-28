class DeviceHistory < ActiveRecord::Base

  attr_protected :created_at

  belongs_to :device, primary_key: :imei

  after_save :update_device
  
  after_save :create_alert_if_has_open_issue

  before_save :set_has_low_batt_and_has_dtc
  
  scope :not_in, lambda { |device_ids| { :conditions => ['device_id NOT IN [?]', device_ids] } }

  def update_device
    has_open_issue = (has_low_batt || has_dtc) ?  1 : 0
    
    if device
      device.update({latest_history_id: id, has_open_issue: has_open_issue, has_low_batt: has_low_batt, has_dtc: has_dtc})
    end
  end

  def formatted_issues
    issues = []
    if has_low_batt
      issues.push 'Low battery'
    end
    if has_dtc
      issues.push 'DTC'
    end

    issues.join(', ')
  end

  def create_alert_if_has_open_issue
    if has_low_batt
      Alert.create({event: 'LOW_BATT', device_id: device_id})
    end
    
    if has_dtc
      Alert.create({event: 'DTC', device_id: device_id})
    end
  end

  def status
    heartbeats_in_last_24_hours = device_histories.where('created_at > ?', 1.day.ago).count

    if heartbeats_in_last_24_hours > 0
      'icon-ok'
    else
      'icon-remove'
    end
  end

  def set_has_low_batt_and_has_dtc
    if dtc_codes.present?
      self.has_dtc = 1
    end

    if vbatt.to_f < 12.5
      self.has_low_batt = 1
    end
  end

end
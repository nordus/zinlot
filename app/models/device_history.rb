class DeviceHistory < ActiveRecord::Base

  attr_protected :created_at

  belongs_to :device, primary_key: :imei

  after_save :add_device_history_id_to_device

  before_save :set_has_low_batt_and_has_dtc

  def add_device_history_id_to_device
    if device
      device.update_attribute('latest_history_id', id)
    end
  end

  def status
    heartbeats_in_last_24_hours = device_histories.where('created_at > ?', 1.day.ago).count > 0

    if heartbeats_in_last_24_hours > 0
      'icon-ok'
    else
      'icon-remove'
    end
  end

  def set_has_low_batt_and_has_dtc
    if dtc_codes
      self.has_dtc = 1
    end

    if vbatt.to_f < 12.5
      self.has_low_batt = 1
    end
  end

end
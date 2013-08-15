class DeviceHistory < ActiveRecord::Base

  belongs_to :device, primary_key: :imei

  def self.create_if_change_in_dtc_or_vbatt(incoming, has_low_batt, has_dtc)
    previous = where({device_id: incoming[:device_id]}).limit(1).first

    if previous
      if incoming['dtc_codes'] != previous['dtc_codes']
        create_new_device_history(incoming, has_low_batt, has_dtc)
      end

      if incoming['has_low_batt'] != previous['has_low_batt']
        create_new_device_history(incoming, has_low_batt, has_dtc)
      end
    else
      create_new_device_history(incoming, has_low_batt, has_dtc)
    end
  end

  def self.create_new_device_history(incoming, has_low_batt, has_dtc)
    dh = new
    dh.has_low_batt = has_low_batt
    dh.has_dtc = has_dtc
    dh.device_id = incoming[:device_id]
    if incoming[:dtc_codes]
      dh.dtc_codes = incoming[:dtc_codes]
    end
    if incoming[:vbatt]
      dh.vbatt = incoming[:vbatt]
    end
    dh.save
  end

end
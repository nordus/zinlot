class Alert < ActiveRecord::Base
  attr_protected :created_at

  after_save :send_sms
  
  after_save :send_alert_to_subscribed_users

  belongs_to :device, primary_key: :imei

  EVENTS = %w[GEOFENCE_ENTER GEOFENCE_EXIT LOW_BATT DTC]

  def send_alert_to_subscribed_users
    # send SMS
    users_with_sms_notification = User.with_sms_notification(event)
    users_with_email_notification = User.with_email_notification(event)
    
    for user in users_with_sms_notification
      # send SMS
    end
    
    for user in users_with_email_notification
      # send Email
    end
  end
  
  def event=(event)
    self.event_type = EVENTS.index(event)
  end
  
  def event
    if event_type
      EVENTS[event_type]
    else
      ''
    end
  end
  
  def send_sms
    return unless Rails.env == 'production'

    if event = 'GEOFENCE_EXIT'
      message = geofence_exit_message
    elsif event = 'LOW_BATT'
      message = low_batt_message
    elsif event = 'DTC'
      message = dtc_message
    end

    return unless message

    # put your own credentials here
    account_sid = 'ACd4c11bdd5c3dbeb127d6f42e7c979b6f'
    auth_token = 'bc3f4277d4bcafeaea13fadd1f6062c9'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.sms.messages.create(
        :from => '+14806488904',
        :to => '+16023413321',
        :body => message
    )
  end

  def geofence_exit_message
    "EXIT Geofence: #{device_id} left geofence #{Geofence.friendly_name(geofence_id)}"
  end

  def low_batt_message
    if device
      "#{device.imei} has a low battery (#{device.latest_vbatt} volts)"
    end
  end

  def dtc_message
    if device
      dtc_codes = device.latest_dtc && device.latest_dtc.split(',')
      s_if_plural = (dtc_codes && dtc_codes.length > 1) ? 's' : ''
      "#{device.imei} reported engine trouble code#{s_if_plural} #{device.latest_dtc}"
    end
  end
end
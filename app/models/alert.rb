require 'twilio-ruby'

class Alert < ActiveRecord::Base
  attr_protected :created_at

  after_save :send_sms
  
  #after_save :send_alert_to_subscribed_users

  belongs_to :device, primary_key: :imei

  validates_presence_of :device_id

  EVENTS = %w[GEOFENCE_ENTER GEOFENCE_EXIT LOW_BATT DTC IGNITION_ON]
  
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
    #return unless Rails.env == 'production'

    if event == 'GEOFENCE_ENTER'
      message = geofence_enter_message
    elsif event == 'GEOFENCE_EXIT'
      message = geofence_exit_message
    elsif event == 'LOW_BATT'
      message = low_batt_message
    elsif event == 'DTC'
      message = dtc_message
    elsif event == 'IGNITION_ON'
      message = ignition_on_message
    end

    p '.. message:'
    p message

    return unless message

    sms_recipients = User.with_sms_notification(event)
    email_recipients = User.with_email_notification(event)

    for sms_recipient in sms_recipients

      phone_numbers = sms_recipient.notification_phone_nbrs

      if phone_numbers.present?

        for phone_number in phone_numbers.split(',')

          # put your own credentials here
          account_sid = 'ACd4c11bdd5c3dbeb127d6f42e7c979b6f'
          auth_token = 'bc3f4277d4bcafeaea13fadd1f6062c9'

          # set up a client to talk to the Twilio REST API
          @client = Twilio::REST::Client.new account_sid, auth_token

          @client.account.sms.messages.create(
              :from => '+14806488904',
              #:to => '+16023413321',
              :to => "+1#{phone_number}",
              :body => message
          )
        end
      end
    end

    for email_recipient in email_recipients
      SendGridMailer.alert_message(email_recipient, event, message).deliver
    end
  end

  def geofence_enter_message
    "ENTER Geofence: #{device_id} entered geofence #{Geofence.friendly_name(geofence_id)}"
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

  def ignition_on_message
    "#{device_id} turned ignition on"
  end
end
class Alert < ActiveRecord::Base
  attr_protected :created_at

  after_save :send_sms

  belongs_to :device, primary_key: :imei

  GEOFENCE_ENTER = 0
  GEOFENCE_EXIT = 1
  LOW_BATTERY = 3

  def event
    case self.event_type
      when GEOFENCE_ENTER
        'GEOFENCE_ENTER'
      when GEOFENCE_EXIT
        'GEOFENCE_EXIT'
      when LOW_BATTERY
        'LOW_BATTERY'
    end
  end

  def send_sms
    return unless Rails.env == 'production'

    if event_type = GEOFENCE_EXIT
      message = geofence_exit_message
    elsif event_type = LOW_BATTERY
      message = battery_low_message
    end

    #return unless geofence_id
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

  def battery_low_message
    if device
      "#{device.imei} has a low battery (#{device.latest_vbatt} volts)"
    end
  end
end
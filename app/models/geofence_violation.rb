class GeofenceViolation < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :created_at

  after_save :send_sms

  def send_sms
    # put your own credentials here
    account_sid = 'ACd4c11bdd5c3dbeb127d6f42e7c979b6f'
    auth_token = 'bc3f4277d4bcafeaea13fadd1f6062c9'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.sms.messages.create(
        :from => '+14806488904',
        :to => '+16023413321',
        :body => "EXIT Geofence: #{device_id} left geofence #{Geofence.friendly_name(geofence_id)}"
    )
  end
end
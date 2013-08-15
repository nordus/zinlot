require 'spec_helper'

describe Alert do

  it '#event returns appropriate event name' do
    alert = Alert.create({
        device_id: '9999999999',
        update_time: Time.now.to_i,
        event_type: 0
                         })

    expect(alert.event).to eql('GEOFENCE_ENTER')
  end
end

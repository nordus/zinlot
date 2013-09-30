class GeofenceViolation < ActiveRecord::Base
  # attr_accessible :title, :body
  #attr_protected :created_at
  attr_accessible :event, :device_id, :event, :geofence_id, :trip_start_at, :update_time
  
  belongs_to :device, primary_key: :imei

  after_save :create_alert

  EVENTS = %w[GEOFENCE_ENTER GEOFENCE_EXIT]

  def event=(event)
    self.event_type = EVENTS.index(event)
  end

  def event
    event_type && EVENTS[event_type]
  end

  def create_alert
    return unless event
    Alert.create({event: event, device_id: device_id, trip_start_at: trip_start_at, geofence_id: String(geofence_id)})
  end
end
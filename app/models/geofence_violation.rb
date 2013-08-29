class GeofenceViolation < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :created_at
  
  belongs_to :device, primary_key: :imei

  after_save :create_alert
  
  def create_alert
    # TODO: implement 'GEOFENCE_ENTER'
    Alert.create({event: 'GEOFENCE_EXIT', device_id: device_id, trip_start_at: trip_start_at, geofence_id: String(geofence_id)})
  end
end
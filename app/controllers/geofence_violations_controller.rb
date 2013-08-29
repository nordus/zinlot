class GeofenceViolationsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  respond_to :json

  def create
    respond_with GeofenceViolation.create(params.permit(:device_id, :geofence_id, :trip_start_at))
  end
  
  def show
  end
end
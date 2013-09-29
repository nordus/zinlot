class GeofenceViolationsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

  respond_to :json

  def create
    respond_with GeofenceViolation.create(params.require(:geofence_violation).permit(:device_id, :event, :geofence_id, :trip_start_at, :update_time))
  end

  def show
    @geofence_violation = Geofence.find(params[:id])
    respond_with @geofence_violation
  end
end
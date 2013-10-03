class HistoricalTripsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  respond_to :html, :json

  def create
    respond_with HistoricalTrip.create(params.require(:historical_trip).permit(:start_at, :device_id, :end_at, :duration, :idle_seconds, :miles, :ending_mileage, :highest_speed, :start_date, :end_date, :num_hard_brake, :num_hard_accel, :num_speed_event, :num_rpm_event, :num_corner_l, :num_corner_r, :num_very_hard_brake, :num_very_hard_accel, :num_hard_corner_l, :num_hard_corner_r, :num_enter_geo_zone, :num_exit_geo_zone))
  end
  
  def index
    ENV["TZ"] = 'US/Arizona'
    @earliest_trip_time ||= Date.today.beginning_of_day.to_i
    @trips = HistoricalTrip.where('end_at > ?', @earliest_trip_time).order('created_at DESC')
    #@trips = HistoricalTrip.where('duration > ?', 0).order('created_at DESC').limit(10)
    @total_miles = 0
    @total_duration = 0
    if @trips.count > 0
      @trip = @trips.first
      @total_trips = @trips.length
      @total_miles = @trip.miles_rounded(miles: @trips.sum('miles'))
      @total_duration = @trip.duration_time(duration: @trips.sum('duration'))
    end
    ENV["TZ"] = 'UTC'
  end

  def week
    @earliest_trip_time = Date.today.beginning_of_week.beginning_of_day.to_i
    index
    render :index
  end

  def show
    @trip = HistoricalTrip.find(params[:id])
    @start_at = @trip[:start_at] * 1000
    @end_at = @trip[:end_at] * 1000
    @device_id = @trip[:device_id]
  end

end

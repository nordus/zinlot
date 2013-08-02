class HistoricalTripsController < ApplicationController

  def index
    ENV["TZ"] = 'US/Arizona'
    @earliest_trip_time ||= Date.today.beginning_of_day.to_i
    @trips = HistoricalTrip.where('end_at > ?', @earliest_trip_time)
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

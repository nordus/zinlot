class HistoricalTripsController < ApplicationController

  def index
    @trips = HistoricalTrip.where('end_at > ?', Date.yesterday.beginning_of_day.to_i)
    @trip = @trips.first
    @total_trips = @trips.length
    @total_miles = @trip.miles_rounded(miles: @trips.sum('miles'))
    @total_duration = @trip.duration_time(duration: @trips.sum('duration'))
  end

  def show
    @trip = HistoricalTrip.find(params[:id])
    @start_at = @trip[:start_at] * 1000
    @end_at = @trip[:end_at] * 1000
    @device_id = @trip[:device_id]
  end

end

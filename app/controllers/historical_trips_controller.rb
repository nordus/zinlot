class HistoricalTripsController < ApplicationController

  def index
    @trips = HistoricalTrip.last(10)
    render :index, layout: 'plain'
  end

  def show
    @trip = HistoricalTrip.find(params[:id])
    @start_at = @trip[:start_at] * 1000
    @end_at = @trip[:end_at] * 1000
    @device_id = @trip[:device_id]
  end

end

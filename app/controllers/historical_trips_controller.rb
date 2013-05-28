class HistoricalTripsController < ApplicationController

  def latest
    @trips = HistoricalTrip.last(10)
  end

end

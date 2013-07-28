class LiveLocationController < ApplicationController
  def index
    @devices = Device.all
    @car_names = {}
    @devices.each {|d| @car_names["#{d['id']}"] = "#{d['name']}"}
    @latest_readings = Reading.latest_readings
  end
end

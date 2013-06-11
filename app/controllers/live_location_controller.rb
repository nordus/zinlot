class LiveLocationController < ApplicationController
  def index
    @devices = Device.includes(:vehicle).all
    @car_names = @devices.each_with_object({}) {|d, hsh| hsh[d.id] = d.vehicle.car.name}
  end
end

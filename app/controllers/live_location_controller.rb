class LiveLocationController < ApplicationController
  def index
    @devices = Device.all
  end
end

class VehiclesController < ApplicationController
  def index
    render :index, layout: 'plain'
  end
end

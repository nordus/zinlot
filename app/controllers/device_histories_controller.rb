class DeviceHistoriesController < ApplicationController

  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    respond_with DeviceHistory.create(params[:device_history])
  end
end
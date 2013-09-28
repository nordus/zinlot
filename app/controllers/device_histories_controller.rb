class DeviceHistoriesController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  respond_to :html, :json

  def create
    respond_with DeviceHistory.create(params.require(:device_history).permit(:device_id, :dtc_codes, :vbatt))
  end
end
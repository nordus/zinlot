class AlertsController < ApplicationController

  include AngularController

  skip_before_filter :verify_authenticity_token, only: [:create, :show]
  skip_before_filter :authenticate_user!, only: [:create, :show]
  respond_to :html, :json
  
  def index
    @search = Device.search(params[:q])
    @low_batt_checked = false
    @dtc_checked = false
    if params[:q]
      @low_batt_checked = params[:q][:has_low_batt_true] == "1"
      @dtc_checked = params[:q][:has_dtc_true] == "1"
    end
    @devices = @search.result.has_open_issues
    device_ids = @search.result.pluck('imei')
    open_issue_ids = @devices.pluck('latest_history_id')
    @alerts = DeviceHistory.where('id NOT IN (?)', open_issue_ids).where({device_id: device_ids}).includes(:device => :vehicle)
  end

  def create
    respond_with Alert.create(alert_params)
  end

  def show
    @alert = Alert.find(params[:id])
    render json: @alert
  end

  private
  def alert_params
    params.require(:alert).permit(:device_id, :event, :trip_start_at, :update_time)
  end

end
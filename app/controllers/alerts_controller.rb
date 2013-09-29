class AlertsController < ApplicationController

  skip_before_filter :verify_authenticity_token
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
    # TODO: refactor me
    #event_types = {'1' => 'LOW_BATTERY', '3' => 'ENGINE_LIGHT_ON'}
    #event_type = event_types[params[:alert][:event_type]]
    #
    #has_low_batt = (event_type is 'LOW_BATTERY') ? 1 : 0
    #has_dtc = (event_type is 'ENGINE_LIGHT_ON') ? 1 : 0

    #DeviceHistory.create_if_change_in_dtc_or_vbatt(alert: params[:alert], has_low_batt: has_low_batt, has_dtc: has_dtc)

    # TODO: update to Rails 4 syntax
    #alert = Alert.new
    #alert.device_id = params[:alert][:device_id]
    #alert.event_type = params[:alert][:event_type]
    #alert.save
    #respond_with alert
  end

end
class CampaignsController < ApplicationController

  before_action :set_campaign, only: [:destroy, :update]
  respond_to :html, :json

  def index
    @campaigns = Campaign.all
    @dealer_lots = DealerLot.all
    @service_issues = Campaign::SERVICE_ISSUES
  end

  def update
    respond_with @campaign.update(campaign_params)
  end

  def create
    @campaign = Campaign.create(campaign_params)
    render file: 'campaigns/show', formats: :json, locals: {campaign: @campaign}
  end

  def destroy
    respond_with @campaign.destroy
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def campaign_params
    params.permit(:target_mileages, :coupon_codes, :dealer_lot_id, :distance_to_dealer, :email_time, :end_date, :is_running, :mileage_interval, :mileage_interval_pct, :name, :odometer, :start_date, :trigger, service_issues: [])
  end
end

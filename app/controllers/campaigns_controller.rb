class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  
  include AngularController

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.all
    @campaign = Campaign.new
    @dealer_lots = DealerLot.all.map {|d| {id: d.id, name: d.name}}
    @all_dealer_lot_id = String(DealerLot.where(name: '_ALL_').first.id)
    @service_notifications = Campaign::SERVICE_NOTIFICATIONS
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
    @dealer_lots = DealerLot.all
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    p params
    @campaign = Campaign.new(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to campaigns_path, notice: 'Campaign was successfully created.' }
        format.json { render action: 'show', status: :created, location: @campaign }
      else
        format.html { render action: 'new' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to campaigns_path, notice: 'Campaign was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:mileage_interval, :mileage_interval_pct, :odometer_gte, :distance_to_dealer_below, :trigger, :on_mileage_reached, :dealer_lot_id, :name, :start_date, :end_date, :nbr_of_emails_sent, :status, :coupon_codes, :email_time, :time_zone, service_notifications: [])
    end
end

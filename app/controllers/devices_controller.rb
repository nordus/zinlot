class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    @search = Device.search(params[:q])
    #@search = Device.includes(:vehicle => [:car, :vehicle_usage]).search(params[:q])
    #@devices = Device.all
    @devices = @search.result
    @mobile_ids = @devices.pluck('imei')
    
    @car_names = {}
    @devices.each {|d| @car_names["#{d['imei']}"] = "#{d['name']}"}
    @latest_readings = Reading.latest_readings(mobile_ids: @mobile_ids)
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    trips = @device.historical_trips
    @engine_hours = Device.duration_time(duration: trips.sum('duration'))
    @total_trips = trips.count
    @total_miles = trips.last && Device.miles_rounded(miles: trips.last[:ending_mileage])
    @vbatt_readings = Reading.where(mobileId: @device[:imei], eventCode: 26).to_a
    @vbatt_chart_hash = {}
    @vbatt_readings.each do |reading|
      @vbatt_chart_hash[Time.at((reading['updateTime']/1000).round)] = reading['vBatt']
    end
    @current_vbatt = @vbatt_readings[@vbatt_readings.count-1]['vBatt']
    readings_with_dtc_codes = Reading.where(mobileId: @device.imei, dtcCount: {:"$gt" => 0})
    @previous_dtc_codes = {}
    readings_with_dtc_codes.each do |reading|
      time = Time.at(reading['updateTime']/1000).strftime('%m/%d %I:%M %p')
      @previous_dtc_codes[time] = []
      dtc_codes = reading['dtcCodes'].split(',')
      for dtc_code in dtc_codes
        @previous_dtc_codes[time].push(Reading.dtc_description(dtc_code))
      end
    end
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render action: 'show', status: :created, location: @device }
      else
        format.html { render action: 'new' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params[:device]
    end
end

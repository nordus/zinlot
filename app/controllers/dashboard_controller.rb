class DashboardController < ApplicationController

  if Rails.env == 'test'
    skip_before_filter :authenticate_user!
  end

  def index
    #@devices = Device.has_open_issues
    @devices = Device.includes(:vehicle => [:car, :vehicle_usage]).has_open_issues
  end
end

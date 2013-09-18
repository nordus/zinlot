class DashboardController < ApplicationController
  def index
    @devices = Device.has_open_issues
  end
end

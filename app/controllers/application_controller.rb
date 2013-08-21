class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_dealer_group
  #has_mobile_fu
  #
  #before_filter :set_request_format

  before_filter :authenticate_user!

  #
  #def set_request_format
  #  request.format = :mobile if is_mobile_device? || is_tablet_device?
  #end

  def current_dealer_group
    @current_dealer_group ||= DealerGroup.find_by_subdomain(request.subdomains[0])
  end
end

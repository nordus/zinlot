class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  has_mobile_fu

  before_filter :set_request_format

  def set_request_format
    request.format = :mobile if is_mobile_device? || is_tablet_device?
  end
end

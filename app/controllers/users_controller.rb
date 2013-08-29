class UsersController < ApplicationController

  include AngularController

  def index
    @users = User.where(id: current_user)
    @current_user = User.find(current_user)
    respond_with @users
  end

  def update
    @user = User.find(params[:id])
    respond_with @user.update(params.permit(:notification_emails, :notification_phone_nbrs, email_notifications: [], sms_notifications: []))
  end

end
class UsersController < ApplicationController

  def communications_set_up
    @user = User.find(current_user)

    if params[:user]
      @user.update(params.require(:user).permit(:notification_emails))
    end
  end

end
class MarketingController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

  def index
  end
end

class SendGridMailer < ActionMailer::Base
  include SendGrid
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  sendgrid_unique_args :mileage => "65535", :vehicle => "Scion TC"
  
  default from: "support@zinlot.com"

  def oil_change_message(user)
    sendgrid_category "Oil Change" 
    # sendgrid_unique_args :key2 => "newvalue2", :key3 => "value3"
    @on_mileage_reached = "75,000"
    mail :to => user.email, :subject => "Terje, Get 20% off your 75,000 mile Oil Change"
  end

  def goodbye_message(user)
    sendgrid_disable :ganalytics
    mail :to => user.email, :subject => "Fare thee well :-("
  end
end
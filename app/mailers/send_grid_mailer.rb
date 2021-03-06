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

  def alert_message(user, subject, body)
    if recipients = user.notification_emails.present? && user.notification_emails.split(',')
      mail :to => recipients, :subject => subject, :body => body
    end
  end

  def campaign_target_mileage_message device_id, campaign
    mail :to => 'tgl@norduscapital.com, navseeker7@gmail.com', :subject => campaign.name, :body => "#{device_id} exceeded #{campaign.target_mileages[device_id]} miles"
  end
end
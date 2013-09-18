ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => 25,
  :domain => "zinlot.com",
  :authentication => :plain,
  :user_name => "tgl@norduscapital.com",
  :password => "hitra123"
}
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :notification_emails, :notification_phone_nbrs, :email_notifications, :sms_notifications

  scope :with_email_notification, lambda { |event| {:conditions => "email_notifications_mask & #{2**EVENTS.index(event.to_s)} > 0 "} }
  scope :with_sms_notification, lambda { |event| {:conditions => "sms_notifications_mask & #{2**EVENTS.index(event.to_s)} > 0 "} }

  EVENTS = Alert::EVENTS

  def email_notifications=(events)
    self.email_notifications_mask = (events & EVENTS).map { |e| 2**EVENTS.index(e) }.sum
  end

  def email_notifications
    EVENTS.reject { |e| ((email_notifications_mask || 0) & 2**EVENTS.index(e)).zero? }
  end

  def email_notification_symbols
    email_notifications.map(&:to_sym)
  end

  def sms_notifications=(events)
    self.sms_notifications_mask = (events & EVENTS).map { |e| 2**EVENTS.index(e) }.sum
  end

  def sms_notifications
    EVENTS.reject { |e| ((sms_notifications_mask || 0) & 2**EVENTS.index(e)).zero? }
  end

  def sms_notification_symbols
    sms_notifications.map(&:to_sym)
  end
end
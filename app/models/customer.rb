class Customer < ActiveRecord::Base
  
  belongs_to :device
  
  attr_accessible :email, :device_id, :name
  
end

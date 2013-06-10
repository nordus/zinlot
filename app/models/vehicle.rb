class Vehicle < ActiveRecord::Base

  has_one :device
  belongs_to :car
  belongs_to :vehicle_usage
end

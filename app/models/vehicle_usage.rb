class VehicleUsage < ActiveRecord::Base
  has_many :vehicles
  attr_protected :id
end

class Vehicle < ActiveRecord::Base
  attr_protected :created_at

  has_one :device
  belongs_to :car
  belongs_to :dealer_lot
  belongs_to :vehicle_usage

  def name
    car && car.name
  end
end
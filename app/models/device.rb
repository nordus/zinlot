class Device < ActiveRecord::Base
  attr_protected :created_at

  belongs_to :vehicle

  has_many :historical_trips

  has_one :car
end
class DealerLot < ActiveRecord::Base
  attr_protected :created_at

  #belongs_to :dealer_group

  has_many :vehicles
end
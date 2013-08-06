class DealerGroup < ActiveRecord::Base
  attr_protected :created_at

  has_many :dealer_lots
end

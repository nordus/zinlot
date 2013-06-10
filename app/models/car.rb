class Car < ActiveRecord::Base

  has_many :vehicles

  def name
    "#{year} #{make} #{model}"
  end
end
class Campaign < ActiveRecord::Base
  
  attr_protected :id
  belongs_to :dealer_lot

  before_save :set_target_mileages

  scope :with_mileage_interval, -> { where(trigger: 'MILEAGE_INTERVAL') }

  def set_target_mileage_to_next_interval device_id
    puts ".. #{device_id} target mileage: #{target_mileages[device_id]}"
    previous_target_mileage = target_mileages[device_id].to_i
    next_target_mileage = previous_target_mileage + (mileage_interval * mileage_interval_pct)
    self.target_mileages[device_id] = next_target_mileage
    puts "-= TARGET_MILEAGES UPDATED =-"
    save!
    puts "... next_target_mileage #{next_target_mileage}"
    puts ".... #{device_id} updated target mileage: #{target_mileages[device_id]}"
  end

  def set_target_mileages
    if trigger == 'MILEAGE_INTERVAL'
      self.target_mileages = Device.all.each_with_object({}) {|d, hash, t = d.latest_trip| hash[d.imei] = (t.ending_mileage.round + (mileage_interval * mileage_interval_pct)) if t}
    end
  end

  SERVICE_ISSUES = %w[LOW_BATT DTC PREDICTIVE_SERVICE]

  def service_issues=(service_issues)
    self.service_issues_mask = (service_issues & SERVICE_ISSUES).map { |si| 2**SERVICE_ISSUES.index(si) }.sum
  end

  def service_issues
    SERVICE_ISSUES.reject { |si| ((service_issues_mask || 0) & 2**SERVICE_ISSUES.index(si)).zero? }
  end

  def service_issues_symbols
    service_issues.map(&:to_sym)
  end
end

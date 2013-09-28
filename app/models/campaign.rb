class Campaign < ActiveRecord::Base
  
  attr_protected :id
  belongs_to :dealer_lot
  
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
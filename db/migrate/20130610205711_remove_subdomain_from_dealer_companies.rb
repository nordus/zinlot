class RemoveSubdomainFromDealerCompanies < ActiveRecord::Migration
  def change
    remove_column :dealer_companies, :subdomain
  end
end

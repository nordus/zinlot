require 'spec_helper'

describe "campaigns/show" do
  before(:each) do
    @campaign = assign(:campaign, stub_model(Campaign,
      :name => "Name",
      :nbr_of_emails_sent => 1,
      :status => "Status",
      :coupon_codes => "Coupon Codes",
      :time_zone => "Time Zone",
      :condition_mileage_gte => 2,
      :condition_device_has_dtc => false,
      :condition_has_low_batt => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/Status/)
    rendered.should match(/Coupon Codes/)
    rendered.should match(/Time Zone/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end

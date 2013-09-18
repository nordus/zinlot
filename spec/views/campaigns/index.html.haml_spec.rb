require 'spec_helper'

describe "campaigns/index" do
  before(:each) do
    assign(:campaigns, [
      stub_model(Campaign,
        :name => "Name",
        :nbr_of_emails_sent => 1,
        :status => "Status",
        :coupon_codes => "Coupon Codes",
        :time_zone => "Time Zone",
        :condition_mileage_gte => 2,
        :condition_device_has_dtc => false,
        :condition_has_low_batt => false
      ),
      stub_model(Campaign,
        :name => "Name",
        :nbr_of_emails_sent => 1,
        :status => "Status",
        :coupon_codes => "Coupon Codes",
        :time_zone => "Time Zone",
        :condition_mileage_gte => 2,
        :condition_device_has_dtc => false,
        :condition_has_low_batt => false
      )
    ])
  end

  it "renders a list of campaigns" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Coupon Codes".to_s, :count => 2
    assert_select "tr>td", :text => "Time Zone".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end

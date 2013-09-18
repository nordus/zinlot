require 'spec_helper'

describe "campaigns/edit" do
  before(:each) do
    @campaign = assign(:campaign, stub_model(Campaign,
      :name => "MyString",
      :nbr_of_emails_sent => 1,
      :status => "MyString",
      :coupon_codes => "MyString",
      :time_zone => "MyString",
      :condition_mileage_gte => 1,
      :condition_device_has_dtc => false,
      :condition_has_low_batt => false
    ))
  end

  it "renders the edit campaign form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", campaign_path(@campaign), "post" do
      assert_select "input#campaign_name[name=?]", "campaign[name]"
      assert_select "input#campaign_nbr_of_emails_sent[name=?]", "campaign[nbr_of_emails_sent]"
      assert_select "input#campaign_status[name=?]", "campaign[status]"
      assert_select "input#campaign_coupon_codes[name=?]", "campaign[coupon_codes]"
      assert_select "input#campaign_time_zone[name=?]", "campaign[time_zone]"
      assert_select "input#campaign_condition_mileage_gte[name=?]", "campaign[condition_mileage_gte]"
      assert_select "input#campaign_condition_device_has_dtc[name=?]", "campaign[condition_device_has_dtc]"
      assert_select "input#campaign_condition_has_low_batt[name=?]", "campaign[condition_has_low_batt]"
    end
  end
end

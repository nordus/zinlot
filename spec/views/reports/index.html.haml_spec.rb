require 'spec_helper'

describe "reports/index" do
  before(:each) do
    assign(:reports, [
      stub_model(Report,
        :q => "Q",
        :interval => 1,
        :format => "Format",
        :user_id => 2,
        :name => "Name",
        :time => 3,
        :time_zone => "Time Zone"
      ),
      stub_model(Report,
        :q => "Q",
        :interval => 1,
        :format => "Format",
        :user_id => 2,
        :name => "Name",
        :time => 3,
        :time_zone => "Time Zone"
      )
    ])
  end

  it "renders a list of reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Q".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Format".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Time Zone".to_s, :count => 2
  end
end

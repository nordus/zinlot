require 'spec_helper'

describe "reports/show" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :q => "Q",
      :interval => 1,
      :format => "Format",
      :user_id => 2,
      :name => "Name",
      :time => 3,
      :time_zone => "Time Zone"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Q/)
    rendered.should match(/1/)
    rendered.should match(/Format/)
    rendered.should match(/2/)
    rendered.should match(/Name/)
    rendered.should match(/3/)
    rendered.should match(/Time Zone/)
  end
end

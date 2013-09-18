require 'spec_helper'

describe "reports/edit" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :q => "MyString",
      :interval => 1,
      :format => "MyString",
      :user_id => 1,
      :name => "MyString",
      :time => 1,
      :time_zone => "MyString"
    ))
  end

  it "renders the edit report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", report_path(@report), "post" do
      assert_select "input#report_q[name=?]", "report[q]"
      assert_select "input#report_interval[name=?]", "report[interval]"
      assert_select "input#report_format[name=?]", "report[format]"
      assert_select "input#report_user_id[name=?]", "report[user_id]"
      assert_select "input#report_name[name=?]", "report[name]"
      assert_select "input#report_time[name=?]", "report[time]"
      assert_select "input#report_time_zone[name=?]", "report[time_zone]"
    end
  end
end

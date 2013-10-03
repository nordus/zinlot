require 'test_helper'
require 'rails/performance_test_help'

class DashboardPageTestTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  test "dashboard_page" do
    load_fixtures
    get '/dashboard/index'
  end
end

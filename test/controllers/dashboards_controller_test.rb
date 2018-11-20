require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get dashboards_show_url
    assert_response :success
  end

end

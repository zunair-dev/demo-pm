require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get assign" do
    get admin_assign_url
    assert_response :success
  end
end

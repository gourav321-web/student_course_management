require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get sign_up" do
    get sessions_sign_up_url
    assert_response :success
  end

  test "should get login" do
    get sessions_login_url
    assert_response :success
  end

  test "should get logout" do
    get sessions_logout_url
    assert_response :success
  end
end

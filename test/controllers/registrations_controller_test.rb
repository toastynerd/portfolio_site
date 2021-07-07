require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_params = {
      username: "testuser",
      email: "testuser@example.com",
      password: "testpassword",
      password_confirmation: "testpassword"
    }
  end

  test "it should have a new page" do
    get sign_up_path
    assert_not_nil @controller.instance_variable_get('@user')
    assert_response :success
  end

  test "it should be able to create a new user with a post request" do
    assert_difference("User.count") do
      post sign_up_path, params: {user: @user_params}
    end
    test_user = @controller.instance_variable_get('@user')
    assert_not_nil test_user

    assert_redirected_to posts_path
  end
end

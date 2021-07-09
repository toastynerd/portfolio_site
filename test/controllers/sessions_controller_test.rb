require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new({
      username: 'existinguser',
      email: 'existinguser@example.com',
      password: 'testuser',
      password_confirmation: 'testuser',
      admin: false
    })
    @user.save
  end
  test "it should have a log in page" do
    get sign_in_path
    assert_response :success
  end

  test "it should log in a user with valid credentials" do
    post sign_in_path, params: {username: @user.username, password: @user.password}

    assert_redirected_to root_path
    assert_equal @user.id, session[:user_id]
    assert_equal "Logged in successfully", flash[:notice]
  end

  test "it should not log in with invalid credentials" do
    post sign_in_path, params: {username: "doesnotexist", password: "invalid"}
    assert_response :success
    assert_nil session[:user_id]
    assert_equal "Invalid Credentials", flash[:notice]
  end

  test "it should be able to log out a current user" do
    #TODO: make this a better test of removing a session user_id
    delete sign_out_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
    assert_equal "Logged out current user", flash[:notice]
  end
end

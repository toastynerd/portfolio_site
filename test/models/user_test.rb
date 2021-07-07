require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user_params = {
      username: 'testuser',
      email: 'testuser@example.com',
      admin: false
    }
  end

  test "it should save with valid data" do
    user = User.new(@user_params)
    user.password = 'testpassword'
    user.password_confirmation = 'testpassword'
    assert user.save
  end

  test "it shouldn't save without a password" do
    user = User.new(@user_params)
    assert_not user.save
  end

  test "it shouldn't save without a password_confirmation" do
    user = User.new(@user_params)
    user.password = 'testpassword'
    assert_not user.save
  end

  test "it shouldn't save if password_confirmations do not match" do
    user = User.new(@user_params)
    user.password = 'testpassword'
    user.password_confirmation = ''
    assert_not user.save
  end

  test "user should require an email" do
    user_params = @user_params.clone
    user_params.delete(:email)
    user = User.new(user_params)
    user.password = 'test'
    user.password_confirmation = 'test'
    assert_not user.save
  end

  test "user should require a username" do
    user_params = @user_params.clone
    user_params.delete(:username)
    user = User.new(user_params)
    user.password = 'test'
    user.password_confirmation = 'test'
    assert_not user.save
  end
end

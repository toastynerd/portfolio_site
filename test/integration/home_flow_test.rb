require "test_helper"

class HomeFlowTest < ActionDispatch::IntegrationTest
  test "should have a static home page" do
    get "/"
    assert_select "h1", "Welcome to Some Awesome Blog"
  end
end

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should have an index" do
    get posts_path
    assert_response :success
  end
end

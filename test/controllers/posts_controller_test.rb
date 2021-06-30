require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should have an index" do
    get posts_path
    assert_response :success
  end

  test "it should have a page to make a new post" do
    get new_post_path

    assert_not_equal nil, @controller.instance_variable_get('@post')
    assert_response :success
  end
end

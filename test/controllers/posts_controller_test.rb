require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should have an index" do
    get posts_path
    assert_response :success
  end

  test "it should have a page to make a new post" do
    get new_post_path

    assert_not_nil @controller.instance_variable_get('@post')
    assert_response :success
  end

  test "it should create a new post with valid data" do
    #TODO write this test
    flunk "test has not been written yet"
  end

  test "it should be able to get an edit page for an existing post" do
    #TODO: write this test
    flunk "test has not been written yet"
  end

  test "it should be able to update with a PATCH request" do
    #TODO: write this test
    flunk "test has not been written yet"
  end

  test "it should be able to update with a PUT request" do
    #TODO: write this test
    flunk "test has not been written yet"
  end

  test "it should be able to a delete a post" do
    #TODO: write this test
    flunk "test has not been written yet"
  end
end

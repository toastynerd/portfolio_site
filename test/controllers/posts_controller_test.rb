require "test_helper"
require "helpers/monkey_patch_helpers"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new({
      username: 'admin',
      email: 'admin@example.com',
      password: 'test',
      password_confirmation: 'test',
      admin: true
    })
    @user.save
    @post_params = {title: "first test post", body: "here is the body"}
    @post_edit_params = {title: "second test post title", body: "another different body"}
  end

  test "should have an index" do
    get posts_path
    assert_response :success
  end

  test "it should have a page to make a new post" do
    set_current_user_admin
    get new_post_path

    assert_not_nil @controller.instance_variable_get('@post')
    assert_response :success

    set_current_user_cleanup
  end

  test "it should have an individual action for a single post" do
    get post_path posts(:test_post)

    test_post = @controller.instance_variable_get('@post')
    assert_not_nil test_post, "no post found in controller action"
    assert_equal "a test post", test_post.title, "post does not have right title"
    assert_response :success

    assert_select "h1", test_post.title 
    assert_select "div.body", test_post.body
  end

  test "it should create a new post with valid data and admin access" do
    set_current_user_admin
    assert_difference("Post.count") do
      post posts_path, params: {post: @post_params}
    end

    test_post = @controller.instance_variable_get('@post')
    assert_not_nil test_post
    assert_equal @post_params[:title], test_post.title
    assert_equal @post_params[:body], test_post.body

    assert_redirected_to post_path(Post.last)
    set_current_user_cleanup
  end

  test "it should be able to get an edit page for an existing post" do
    set_current_user_admin
    get edit_post_path posts(:test_post)

    test_post = @controller.instance_variable_get('@post')
    assert_not_nil test_post
    assert_equal test_post, posts(:test_post)

    assert_response :success

    assert_select "h1", "Editing: #{test_post.title}"

    set_current_user_cleanup
  end

  test "it should be able to update with a PATCH request" do
    set_current_user_admin
    assert_no_difference("Post.count") do
      patch post_path posts(:test_post), params: {post: @post_edit_params}
    end

    test_post = @controller.instance_variable_get('@post')
    assert_not_nil test_post
    assert_equal @post_edit_params[:title], test_post.title
    assert_equal @post_edit_params[:body], test_post.body

    assert_redirected_to post_path posts(:test_post)
    set_current_user_cleanup
  end

  test "it should be able to update with a PUT request" do
    set_current_user_admin
    assert_no_difference("Post.count") do
      put post_path posts(:test_post), params: {post: @post_edit_params}
    end

    test_post = @controller.instance_variable_get('@post')
    assert_not_nil test_post
    assert_equal @post_edit_params[:title], test_post.title
    assert_equal @post_edit_params[:body], test_post.body

    assert_redirected_to post_path posts(:test_post)
    set_current_user_cleanup
  end

  test "it should be able to a delete a post" do
    set_current_user_admin
    assert_difference("Post.count", -1) do
      delete post_path posts(:test_post)
    end

    assert_redirected_to posts_path
    set_current_user_cleanup
  end
end

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_params = {title: "first test post", body: "here is the body"}
    @post_edit_params = {title: "second test post title", body: "another different body"}
  end

  test "should have an index" do
    get posts_path
    assert_response :success

    assert_select "a", "edit", 2
    assert_select "a", "delete", 2
    assert_select "input[value=?]", "Create a New Post"
  end

  test "it should have a page to make a new post" do
    get new_post_path

    assert_not_nil @controller.instance_variable_get('@post')
    assert_response :success

    assert_select "form"
    assert_select "label", 2
    assert_select "textarea"
    assert_select "input", 2
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

  test "it should create a new post with valid data" do
    assert_difference("Post.count") do
      post posts_path, params: {post: @post_params}
    end

    test_post = @controller.instance_variable_get('@post')
    assert_not_nil test_post
    assert_equal @post_params[:title], test_post.title
    assert_equal @post_params[:body], test_post.body

    assert_redirected_to post_path(Post.last)
  end

  test "it should be able to get an edit page for an existing post" do
    get edit_post_path posts(:test_post)

    test_post = @controller.instance_variable_get('@post')
    assert_not_nil test_post
    assert_equal test_post, posts(:test_post)

    assert_response :success

    assert_select "h1", "Editing: #{test_post.title}"

    assert_select "form"
    assert_select "label", 2
    assert_select "input", 3 #there's a hidden input with a token in it for the edit
  end

  test "it should be able to update with a PATCH request" do
    assert_no_difference("Post.count") do
      patch post_path posts(:test_post), params: {post: @post_edit_params}
    end

    test_post = @controller.instance_variable_get('@post')
    assert_not_nil test_post
    assert_equal @post_edit_params[:title], test_post.title
    assert_equal @post_edit_params[:body], test_post.body

    assert_redirected_to post_path posts(:test_post)
  end

  test "it should be able to update with a PUT request" do
    assert_no_difference("Post.count") do
      put post_path posts(:test_post), params: {post: @post_edit_params}
    end

    test_post = @controller.instance_variable_get('@post')
    assert_not_nil test_post
    assert_equal @post_edit_params[:title], test_post.title
    assert_equal @post_edit_params[:body], test_post.body

    assert_redirected_to post_path posts(:test_post)
  end

  test "it should be able to a delete a post" do
    assert_difference("Post.count", -1) do
      delete post_path posts(:test_post)
    end

    assert_redirected_to posts_path
  end
end

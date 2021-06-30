require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @post_params = {
      title: "a test title",
      body: "here is a non empty body"
    }
  end

  test "should require a title" do
    post = Post.new
    assert_not post.save
  end

  test "should require a body" do
    post = Post.new(title: "here is a test title")
    assert_not post.save
  end

  test "should save with valid data" do
    post =Post.new(@post_params)
    assert post.save
  end
end

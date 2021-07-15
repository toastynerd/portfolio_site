require "test_helper"

class LinkTest < ActiveSupport::TestCase
  setup do
    @params = {
      body: 'http://test.example.com',
      icon_url: 'http://test.example.com/test.png'
    }
  end

  test "it should save with valid params" do
    post = projects(:test_project).links.new(@params)
    assert post.save
  end

  test "it shouldn't save without valid params" do
    link = projects(:test_project).links.new()
    assert_not link.save
  end
end

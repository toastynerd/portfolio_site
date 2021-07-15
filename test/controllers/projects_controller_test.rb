require "test_helper"
require "helpers/monkey_patch_helpers"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new({
      username: 'admin',
      email: 'admin@example.com',
      password: 'test',
      password_confirmation: 'test',
      admin: true
    })
    @user.save
    @params = {
      title: 'a test project',
      description: 'something about tests',
    }
  end

  test "should have an index" do
    get projects_path
    assert_response :success
    assert_select "h1", "Projects"
    assert_select "h2", projects(:test_project).title
  end

  test "should have a new page with an admin login" do
    set_current_user_admin
    get new_project_path

    assert_not_nil @controller.instance_variable_get('@project')
    assert_response :success
    assert_select "h1", "Creating a New Project"
    assert_select "label", "Title"

    set_current_user_cleanup
  end
end

require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  setup do 
    @project_params = {
      title: 'test project',
      description: 'test description'
    }
  end

  test "it should save with valid params" do
    project = Project.new(@project_params)
    assert project.save
  end

  test "it should not save with invalid params" do
    project = Project.new()
    assert_not project.save
  end
end

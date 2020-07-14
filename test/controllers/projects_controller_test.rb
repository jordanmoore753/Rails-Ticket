require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:dave)
  end

  test 'should not get new' do
    get new_project_url
    assert_response 302
  end

  test 'should get new' do
    log_in_as @user
    get new_project_url
    assert_response :success
  end

  test 'should not get edit' do
    get edit_project_url 1
    assert_response 302
  end

  test 'should get edit' do
    log_in_as @user
    get edit_project_url 1
    assert_response :success
  end

  test 'should get index' do
    get projects_url
    assert_response :success
  end

  test 'should get show' do
    get project_url 2
    assert_response :success
  end
end

require 'test_helper'

class ProjectFlowTest < ActionDispatch::IntegrationTest
  def setup
    @users = [users(:dave), users(:jondan)]
    @project_one = projects(:one)
  end

  test 'should not create project, not logged in' do 
    assert_no_difference 'Project.count' do 
      post projects_url, params: { project: { name: 'yes', description: 'valid' }}
    end

    assert_response 302
    assert_template 'projects/index'
    assert_not flash.empty?
  end

  test 'should not create project, invalid params' do
    assert_no_difference 'Project.count' do 
      post projects_url, params: { project: { name: 'yes' }}
    end

    assert_no_difference 'Project.count' do 
      post projects_url, params: { project: { name: 'yes', sandwich: 'oh yeah!' }}
    end

    assert_response 200

    assert_template 'projects/index'
    assert_not flash.empty?
  end

  test 'should create project' do
    log_in_as(@users.first)

    assert_difference 'Project.count' do 
      post projects_url, params: { project: { name: 'yes', description: 'woah!' }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'projects/show'
    assert_not flash.empty?
  end

  test 'should update project' do

  end

  test 'should not update project, invalid params' do

  end

  test 'should not update project, not logged in' do

  end

  test 'should destroy project' do

  end

  test 'should not destroy project, not logged in' do

  end
end

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
    follow_redirect!

    assert_template 'projects/index'
    assert_not flash.empty?
  end

  test 'should not create project, invalid params' do
    log_in_as @users.first

    assert_no_difference 'Project.count' do 
      post projects_url, params: { project: { name: 'yes', sandwich: 'oh yeah!' }}
    end

    assert_response 200
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
    log_in_as(@users.first)

    original_name, original_desc = @project_one.name, @project_one.description

    patch project_url @project_one.id, params: { project: { name: 'shoby', description: 'yum' }}

    assert_response 302
    follow_redirect!

    assert_template 'projects/show'
    assert_not flash.empty?

    @project_one.reload

    assert_not original_name == @project_one.name
    assert_not original_desc == @project_one.description
  end

  test 'should update project without invalid params' do
    log_in_as(@users.first)

    original_name, original_desc = @project_one.name, @project_one.description

    patch project_url @project_one.id, params: { project: { name: 'soby', tanker: 'one', description: 'yum' }}

    assert_response 302
    follow_redirect!

    assert_template 'projects/show'
    assert_not flash.empty?
    
    @project_one.reload

    assert_not original_name == @project_one.name
    assert_not original_desc == @project_one.description
  end

  test 'should not update project, not logged in' do
    original_name, original_desc = @project_one.name, @project_one.description

    patch project_url @project_one.id, params: { project: { name: 'shooby', description: 'yum' }}

    assert_response 302
    follow_redirect!

    assert_template 'projects/index'
    assert_not flash.empty?
    
    @project_one.reload

    assert original_name == @project_one.name
    assert original_desc == @project_one.description
  end

  test 'should destroy project' do
    log_in_as(@users.first)

    number_of_projects = Project.all.length

    delete project_url @project_one

    assert_response 302
    follow_redirect!

    assert_template 'projects/index'
    assert_not flash.empty?

    assert number_of_projects == Project.all.length + 1
  end

  test 'should not destroy project, not logged in' do
    assert_no_difference 'Project.count' do
      delete project_url @project_one.id
    end

    assert_response 302
    follow_redirect!
    assert_template 'projects/index'
    assert_not flash.empty?
  end
end

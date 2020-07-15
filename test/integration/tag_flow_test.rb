require 'test_helper'

class TagFlowTest < ActionDispatch::IntegrationTest
  def setup
    @users = [users(:dave), users(:jondan)]
    @tag_one = tags(:one)
  end

  test 'should not create tag, not logged in' do 
    assert_no_difference 'Tag.count' do 
      post create_tag_url, params: { tag: { name: 'yes', body: 'woah', status: 'blocked' }}
    end

    assert_response 302
    assert_template 'tags/index'
    assert_not flash.empty?
  end

  test 'should create tag without invalid params' do
    log_in_as(@users.first)

    assert_difference 'Tag.count' do 
      post create_tag_url, params: { tag: { name: 'yes', body: 'woah', status: 'blocked', sandwich: 'oh yeah!' }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'tags/index'
    assert_not flash.empty?

    tag_three = tag.find_by(name: 'yes')
    assert tag_three
    assert_not tag_three.body
  end

  test 'should create tag' do
    log_in_as(@users.first)

    assert_difference 'Tag.count' do 
      post create_tag_url, params: { tag: { name: 'yes' }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'tags/show'
    assert_not flash.empty?
  end

  test 'should update tag' do
    log_in_as(@users.first)

    original_name = @tag_one.name

    patch update_tag_url 1, params: { tag: { name: 'shooby' }}

    assert_response 302
    follow_redirect!

    assert_template 'tags/show'
    assert_not flash.empty?

    @tag_one.reload

    assert_not original_name, @tag_one.name
  end

  test 'should update tag without invalid params' do
    log_in_as(@users.first)

    original_name = @tag_one.name
    
    patch update_tag_url 1, params: { tag: { name: 'yesm', tanker: 'one' }}

    assert_response 302
    follow_redirect!

    assert_template 'tags/show'
    assert_not flash.empty?
    
    @tag_one.reload

    assert_not original_name, @tag_one.name
    assert_not @tag_one.tanker
  end

  test 'should not update tag, not logged in' do
    original_name = @tag_one.name

    patch update_tag_url 1, params: { tag: { name: 'shooby' }}

    assert_response 200
    assert_template 'tags/edit'
    assert_not flash.empty?
    
    @tag_one.reload

    assert original_name, @tag_one.name
  end

  test 'should destroy tag' do
    log_in_as(@users.first)

    assert_difference 'Tag.count' do
      delete destroy_tag_url 1
    end

    assert_response 302
    follow_redirect!

    assert_template 'tags/index'
    assert_not flash.empty?
  end

  test 'should not destroy tag, not logged in' do
    assert_no_difference 'Tag.count' do
      delete destroy_tag_url 1
    end

    assert_response 200
    assert_template 'tags/show'
    assert_not flash.empty?
  end
end

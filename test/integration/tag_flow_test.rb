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
    follow_redirect!

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

    tag_three = Tag.find_by(name: 'yes')

    assert tag_three
  end

  test 'should create tag' do
    log_in_as(@users.first)

    assert_difference 'Tag.count' do 
      post create_tag_url, params: { tag: { name: 'yes' }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'tags/index'
    assert_not flash.empty?
  end

  test 'should update tag' do
    log_in_as(@users.first)

    original_name = @tag_one.name

    patch update_tag_url @tag_one, params: { tag: { name: 'shooby' }}

    assert_response 302
    follow_redirect!

    assert_template 'tags/index'
    assert_not flash.empty?

    @tag_one.reload

    assert_not original_name == @tag_one.name
  end

  test 'should update tag without invalid params' do
    log_in_as(@users.first)

    original_name = @tag_one.name
    
    patch update_tag_url @tag_one, params: { tag: { name: 'yesm', tanker: 'one' }}

    assert_response 302
    follow_redirect!

    assert_template 'tags/index'
    assert_not flash.empty?
    
    @tag_one.reload

    assert_not original_name == @tag_one.name
  end

  test 'should not update tag, not logged in' do
    original_name = @tag_one.name

    patch update_tag_url @tag_one, params: { tag: { name: 'shooby' }}

    assert_response 302
    follow_redirect!

    assert_template 'tags/index'
    assert_not flash.empty?
    
    @tag_one.reload

    assert original_name == @tag_one.name
  end

  test 'should destroy tag' do
    log_in_as(@users.first)

    initial_count = Tag.all.length

    delete destroy_tag_url @tag_one

    assert_response 302
    follow_redirect!

    assert_template 'tags/index'
    assert_not flash.empty?
    assert initial_count == Tag.all.length + 1
  end

  test 'should not destroy tag, not logged in' do
    assert_no_difference 'Tag.count' do
      delete destroy_tag_url @tag_one
    end

    assert_response 302
    follow_redirect!
    assert_template 'tags/index'
    assert_not flash.empty?
  end
end

require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:dave)
    @tag_one = tags(:one)
  end

  test "should not get new" do
    get tags_new_url
    assert_response 302
  end

  test 'should get new' do
    log_in_as(@user)
    get tags_new_url
    assert_response :success
  end

  test 'should get edit' do
    log_in_as(@user)
    get edit_tag_url @tag_one
    assert_response :success    
  end

  test 'should not get edit' do
    get edit_tag_url @tag_one
    assert_response 302   
  end

  test 'should get index' do
    get tags_url 
    assert_response :success
  end
end

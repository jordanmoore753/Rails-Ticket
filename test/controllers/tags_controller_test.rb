require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:dave)
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
    get edit_tag_url 1
    assert_response :success    
  end

  test 'should not get edit' do
    get edit_tag_url 1
    assert_response 302   
  end

  test 'should get index' do
    get tags_url 
    assert_response :success
  end
end

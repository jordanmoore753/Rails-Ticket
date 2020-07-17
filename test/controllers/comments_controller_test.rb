require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_one = users(:dave)
  end

  test 'get edit comment' do 
    log_in_as(@user_one)
    get edit_ticket_comment_path 1, 1
    assert_response :success
  end

  test 'not get edit comment, not logged in' do
    get edit_ticket_comment_path 1, 1
    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert_not flash.empty?   
  end
end

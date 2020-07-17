require 'test_helper'

class CommentFlowTest < ActionDispatch::IntegrationTest
  def setup
    @dave = users(:dave)
    @jondan = users(:jondan)
    @first_comment = Comment.first
  end

  test 'should not update, not correct user' do 
    log_in_as @jondan
    original_body = @first_comment.body

    patch ticket_comment_path(1, 1), params: { comment: { body: 'yes' }} 

    assert_response 302
    follow_redirect!

    @first_comment.reload
    assert_equal original_body, @first_comment.body
    assert_template 'tickets/show'
  end

  test 'should update' do
    log_in_as @dave
    original_body = @first_comment.body

    patch ticket_comment_path(1, 1), params: { comment: { body: 'ye,mmms' }} 

    assert_response 302
    follow_redirect!

    @first_comment.reload
    assert original_body != @first_comment.body
    assert_template 'tickets/show'
  end

  test 'should create' do
    log_in_as @dave

    post ticket_comments_url(1), params: { comment: { body: 'WOAH!' }}

    assert_response 302
    follow_redirect!

    assert Comment.last.body == 'WOAH!'
    assert_template 'tickets/show'
    assert_not flash.empty?
  end

  test 'should not create, not logged in' do
    post ticket_comments_url(1), params: { comment: { body: 'WOAH!' }}

    assert_response 302
    follow_redirect!

    assert Comment.last.body != 'WOAH!'
    assert_template 'tickets/show'
    assert_not flash.empty?
  end

  test 'should not destroy, not correct user' do
    log_in_as @jondan

    delete ticket_comment_path(1,1)

    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert Comment.find(1)
    assert_not flash.empty?
  end

  test 'should destroy' do
    log_in_as @dave

    assert Comment.all.length == 2
    
    delete ticket_comment_path(1,1)

    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert Comment.all.length == 1
    assert_not flash.empty?   
  end
end

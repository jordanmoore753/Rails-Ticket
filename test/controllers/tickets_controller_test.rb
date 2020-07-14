require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:dave)
  end

  test 'should not get new' do
    get new_ticket_url
    assert_response 302
  end

  test 'should get new' do
    log_in_as @user
    get new_ticket_url 1
    assert_response :success
  end

  test 'should not get edit' do
    get edit_ticket_url 1
    assert_response 302
  end

  test 'should get edit' do
    log_in_as @user
    get edit_ticket_url 1
    assert_response :success
  end

  test 'should get index' do
    get tickets_url
    assert_response :success
  end

  test 'should get show' do
    get ticket_url 1
    assert_response :success
  end
end

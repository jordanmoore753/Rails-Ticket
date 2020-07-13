require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_ticket_url
    assert_response :success
  end

  test 'should get edit' do
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

require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_project_ticket_url 1
    assert_response :success
  end

  test 'should get edit' do
    get edit_project_ticket_url 1,3
    assert_response :success
  end

  test 'should get index' do
    get project_tickets_url 1
    assert_response :success
  end

  test 'should get show' do
    get project_ticket_url 1,3
    assert_response :success
  end
end

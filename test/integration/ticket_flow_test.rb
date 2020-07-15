require 'test_helper'

class TicketFlowTest < ActionDispatch::IntegrationTest
  def setup
    @users = [users(:dave), users(:jondan)]
    @ticket_one = tickets(:one)
  end

  test 'should not create ticket, not logged in' do 
    assert_no_difference 'Ticket.count' do 
      post tickets_url, params: { ticket: { name: 'yes', body: 'woah', status: 'blocked' }}
    end

    assert_response 302
    assert_template 'tickets/index'
    assert_not flash.empty?
  end

  test 'should create ticket without invalid params' do
    log_in_as(@users.first)

    assert_difference 'Ticket.count' do 
      post tickets_url, params: { ticket: { name: 'yes', body: 'woah', status: 'blocked', sandwich: 'oh yeah!' }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'tickets/index'
    assert_not flash.empty?

    ticket_three = Ticket.find_by(status: 'blocked', body: 'woah', name: 'yes')
    assert ticket_three
    assert_not ticket_three.sandwich
  end

  test 'should create ticket' do
    log_in_as(@users.first)

    assert_difference 'Ticket.count' do 
      post tickets_url, params: { ticket: { name: 'yes', body: 'woah', status: 'blocked' }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert_not flash.empty?
  end

  test 'should update ticket' do
    log_in_as(@users.first)

    original_name, original_body, original_status = @ticket_one.name, @ticket_one.body, @ticket_one.status

    patch ticket_url 1, params: { ticket: { name: 'shooby', body: 'yum', status: 'fixed' }}

    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert_not flash.empty?

    @ticket_one.reload

    assert_not original_name, @ticket_one.name
    assert_not original_body, @ticket_one.body
    assert_not original_status, @ticket_one.status
  end

  test 'should update ticket without invalid params' do
    log_in_as(@users.first)

    original_name, original_body, original_status = @ticket_one.name, @ticket_one.body, @ticket_one.status

    patch ticket_url 1, params: { ticket: { name: 'yesm', body: 'woahm', status: 'fixed', tanker: 'one' }}

    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert_not flash.empty?
    
    @ticket_one.reload

    assert_not original_name, @ticket_one.name
    assert_not original_body, @ticket_one.body
    assert_not original_status, @ticket_one.status
    assert_not @ticket_one.tanker
  end

  test 'should not update ticket, not logged in' do
    original_name, original_body, original_status = @ticket_one.name, @ticket_one.body, @ticket_one.status

    patch ticket_url 1, params: { ticket: { name: 'shooby', body: 'yum', status: 'blocked' }}

    assert_response 200
    assert_template 'tickets/edit'
    assert_not flash.empty?
    
    @ticket_one.reload

    assert original_name, @ticket_one.name
    assert original_body, @ticket_one.body
    assert original_status, @ticket_one.status
  end

  test 'should destroy ticket' do
    log_in_as(@users.first)

    assert_difference 'Ticket.count' do
      delete ticket_url 1
    end

    assert_response 302
    follow_redirect!

    assert_template 'tickets/index'
    assert_not flash.empty?
  end

  test 'should not destroy ticket, not logged in' do
    assert_no_difference 'Ticket.count' do
      delete ticket_url 1
    end

    assert_response 200
    assert_template 'tickets/show'
    assert_not flash.empty?
  end
end

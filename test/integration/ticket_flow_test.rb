require 'test_helper'

class TicketFlowTest < ActionDispatch::IntegrationTest
  def setup
    @users = [users(:dave), users(:jondan)]
    @ticket_one = tickets(:one)
    @project_one_id = projects(:one).id
  end

  test 'should not create ticket, not logged in' do 
    assert_no_difference 'Ticket.count' do 
      post tickets_url, params: { ticket: { name: 'yes', body: 'woah', status: 'blocked', assignee: @users.first.id, project_id: @project_one_id }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'tickets/index'
    assert_not flash.empty?
  end

  test 'should create ticket without invalid params' do
    log_in_as(@users.first)

    assert_difference 'Ticket.count' do 
      post tickets_url, params: { ticket: { name: 'yes', body: 'woah', status: 'blocked', sandwich: 'oh yeah!', assignee: @users.first.id, project_id: @project_one_id }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert_not flash.empty?

    ticket_three = Ticket.find_by(status: 'blocked', body: 'woah', name: 'yes')
    assert ticket_three
  end

  test 'should create ticket' do
    log_in_as(@users.first)

    assert_difference 'Ticket.count' do 
      post tickets_url, params: { ticket: { name: 'yes', body: 'woah', status: 'blocked', assignee: @users.first.id, project_id: @project_one_id }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert_not flash.empty?
  end

  test 'should update ticket' do
    log_in_as(@users.first)

    original_name, original_body, original_status = @ticket_one.name, @ticket_one.body, @ticket_one.status

    patch ticket_url @ticket_one.id, params: { ticket: { name: 'shooby', body: 'yum', status: 'fixed', assignee: @users.first.id, project_id: @project_one_id }}

    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert_not flash.empty?

    @ticket_one.reload

    assert_not original_name == @ticket_one.name
    assert_not original_body == @ticket_one.body
    assert_not original_status == @ticket_one.status
  end

  test 'should update ticket without invalid params' do
    log_in_as(@users.first)

    original_name, original_body, original_status = @ticket_one.name, @ticket_one.body, @ticket_one.status

    patch ticket_url @ticket_one.id, params: { ticket: { name: 'yesm', body: 'woahm', status: 'fixed', tanker: 'one', assignee: @users.first.id, project_id: @project_one_id }}

    assert_response 302
    follow_redirect!

    assert_template 'tickets/show'
    assert_not flash.empty?
    
    @ticket_one.reload

    assert_not original_name == @ticket_one.name
    assert_not original_body == @ticket_one.body
    assert_not original_status == @ticket_one.status
  end

  test 'should not update ticket, not logged in' do
    original_name, original_body, original_status = @ticket_one.name, @ticket_one.body, @ticket_one.status

    patch ticket_url @ticket_one.id, params: { ticket: { name: 'shooby', body: 'yum', status: 'blocked', assignee: @users.first.id, project_id: @project_one_id }}

    assert_response 302
    follow_redirect!

    assert_template 'tickets/index'
    assert_not flash.empty?
    
    @ticket_one.reload

    assert original_name == @ticket_one.name
    assert original_body == @ticket_one.body
    assert original_status == @ticket_one.status
  end

  test 'should destroy ticket' do
    log_in_as(@users.first)

    initial_count = Ticket.all.length

    delete ticket_url @ticket_one.id

    assert_response 302
    follow_redirect!

    assert_template 'tickets/index'
    assert_not flash.empty?
    assert initial_count == Ticket.all.length + 1
  end

  test 'should not destroy ticket, not logged in' do
    assert_no_difference 'Ticket.count' do
      delete ticket_url @ticket_one.id
    end

    assert_response 302
    follow_redirect!

    assert_template 'tickets/index'
    assert_not flash.empty?
  end
end

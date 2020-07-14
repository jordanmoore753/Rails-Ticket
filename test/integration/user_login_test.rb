require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:dave)
    @user_two = users(:jondan)
  end

  test 'should not login, invalid information' do 
    post login_path, params: { session: { email: '', password: '' }}

    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'should not login, already logged in' do
    log_in_as(@user)

    assert_response 302
    follow_redirect!

    log_in_as(@user_two)

    assert_response 302
    follow_redirect!

    assert_not flash.empty?
    assert_template 'projects/index'
  end

  test 'should login' do
    get login_path
    assert_not cookies[:user_id]

    log_in_as(@user)
    assert_response 302
    follow_redirect!

    assert_template 'projects/index'
    assert_not flash.empty?
    assert session[:user_id]
  end

  test 'should logout' do
    log_in_as(@user)
    delete logout_path @user.id

    assert_response 302
    follow_redirect!

    assert_template 'sessions/new'
    assert_not flash.empty?
  end
end

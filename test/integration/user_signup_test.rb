require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:dave)
  end

  test 'should not signup, already logged in' do
    log_in_as(@user)

    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: 'Jondar', 
                                          email: 'jj', 
                                          password: 'foob1!', 
                                          password_confirmation: 'foob1!' }}
    end

    assert_response 302
    follow_redirect!

    assert_template 'projects/index'
    assert_not flash.empty?      
  end

  test 'should not signup, not valid email' do
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: 'Jondar', 
                                          email: 'jj', 
                                          password: 'foob1!', 
                                          password_confirmation: 'foob1!' }}
    end                                        

    assert_template 'users/new'
    assert_select 'div#error_explanation'                                  
  end

  test 'should not signup, not valid password' do
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: 'Jondar', 
                                          email: 'jj@sandwich.com', 
                                          password: 'foob', 
                                          password_confirmation: 'foob' }}
    end                                        

    assert_template 'users/new'
    assert_select 'div#error_explanation'                                   
  end

  test 'should not signup, not matching pw' do
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: 'Jondar', 
                                          email: 'jj@sandwich.com', 
                                          password: 'foob1!', 
                                          password_confirmation: 'foob' }}
    end                                        

    assert_template 'users/new'
    assert_select 'div#error_explanation'                                   
  end

  test 'should not signup, not matching pw conf' do
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: 'Jondar', 
                                          email: 'jj@sand.com', 
                                          password: 'foob', 
                                          password_confirmation: 'foob1!' }}
    end                                        

    assert_template 'users/new'
    assert_select 'div#error_explanation'                                   
  end

  test 'should signup' do
    assert_difference 'User.count' do
      post signup_path, params: { user: { name: 'Jondar', 
                                          email: 'jj@sandwich.com', 
                                          password: 'foob1!', 
                                          password_confirmation: 'foob1!' }}
    end                                        

    assert_response 302
    follow_redirect!

    assert_template 'sessions/new'
    assert_not flash.empty?                                        
  end
end

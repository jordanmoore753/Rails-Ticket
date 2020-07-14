module ApplicationHelper
  def current_user
    if session[:user_id]
      return User.find session[:user_id]
    end

    nil
  end
end

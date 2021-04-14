class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    return if logged_in?

    flash[:error] = 'You must be logged in to perform that action'
    redirect_to session_new_path
  end

  def account_params
    params.require(:user).permit(:username, :password)
  end
end

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  include Exceptions::ApplicationErrors
  rescue_from AccountError, with: :respond_error

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

  def respond_success(message, path)
    flash[:notice] = message
    redirect_to(path)
  end

  protected

  def respond_error(error)
    flash[:alert] = error.message
    redirect_to(error.path)
  end
end

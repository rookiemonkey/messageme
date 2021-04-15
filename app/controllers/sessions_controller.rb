class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: account_params[:username])
    raise AccountError.new(message: 'Incorrect username and password', path: session_new_path) unless user&.authenticate(account_params[:password])

    session[:user_id] = user.id
    respond_success('Logged in successfully', root_path)
  end

  def destroy
    session[:user_id] = nil
    respond_success('Logged out successfully', session_new_path)
  end
end

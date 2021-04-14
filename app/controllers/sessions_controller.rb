class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: account_params[:username])
    return unless user&.authenticate(account_params[:password])

    session[:user_id] = user.id
    flash[:notice] = 'Logged in successfully'
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out successfully'
  end
end

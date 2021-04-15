class RegistrationsController < ApplicationController
  def new; end

  def create
    user = User.create(account_params)
    raise AccountError.new(message: user.errors.full_messages.first, path: registration_new_path) unless user.valid?

    session[:user_id] = user.id
    respond_success('Account created successfully', root_path)
  end
end

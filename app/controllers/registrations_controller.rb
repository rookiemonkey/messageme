class RegistrationsController < ApplicationController
  def new; end

  def create
    User.create(account_params)
  end
end

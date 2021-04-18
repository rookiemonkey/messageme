class ApiController < ApplicationController
  before_action :require_user
  before_action :set_raw_conversations
  before_action :set_conversations

  def users
    matched_users = User.select(:id, :username).where('username LIKE ?', "%#{params[:username]}%")

    @users = []

    matched_users.each do |found_user|
      next if found_user.id == current_user.id

      existing_conversation = @conversations.find { |convo| convo[:other_user].id == found_user.id }
      conversation_id = existing_conversation ? existing_conversation[:conversation_id] : nil
      @users << { id: found_user.id, username: found_user.username, conversation_id: conversation_id }
    end

    render json: @users
  end
end

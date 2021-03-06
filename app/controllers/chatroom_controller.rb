class ChatroomController < ApplicationController
  before_action :require_user
  before_action :set_raw_conversations
  before_action :set_conversations

  def chats; end

  def chat
    conversation_one = @raw_conversations.find_by(user_one: params[:other_user_id])
    conversation_two = @raw_conversations.find_by(user_two: params[:other_user_id])
    @messages = conversation_one.messages.order('created_at') if conversation_one
    @messages = conversation_two.messages.order('created_at') if conversation_two
    @messages = [] if conversation_one.nil? && conversation_two.nil?
  end

  def new_chat
    new_conversation = Conversation.create(user_one_id: current_user.id, user_two_id: params[:other_user_id])
    redirect_to "#{chat_path(params[:other_user_id])}?conversation_id=#{new_conversation.id}"
  end

  def message
    existing_conversation = current_user.existing_conversation_with(params[:other_user_id])
    message = nil

    if existing_conversation
      message = existing_conversation.messages.create(body: params[:message], user: current_user)
    else
      new_conversation = Conversation.create(user_one_id: current_user.id, user_two_id: params[:other_user_id])
      message = new_conversation.messages.create(body: params[:message], user: current_user)
    end

    existing_conversation.updated_at = message.created_at
    existing_conversation.save

    ActionCable.server.broadcast("chatroom_#{existing_conversation.id}", message: JSON.parse(message.to_json), updated_at: format_date(existing_conversation.updated_at))
  end
end

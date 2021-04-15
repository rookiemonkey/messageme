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
  end

  private

  def set_raw_conversations
    @raw_conversations = Conversation.where(user_one: current_user).or(Conversation.where(user_two: current_user))
  end

  def set_conversations
    @conversations = @raw_conversations.map { |conversation| conversation.who_talks_to(current_user) }
  end
end

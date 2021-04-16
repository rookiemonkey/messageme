class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_#{params[:conversation_id]}"
  end
end

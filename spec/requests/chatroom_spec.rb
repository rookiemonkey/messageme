require 'rails_helper'

RSpec.describe 'Chatrooms', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before { login(user) }

  describe 'GET /' do
    before { get root_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders chats template' do
      expect(response).to render_template(:chats)
    end
  end

  describe 'GET /:other_user_id' do
    before do
      conversation = Conversation.create(user_one: user, user_two: other_user)
      2.times { conversation.messages.create(body: 'Test', user: user) }
      2.times { conversation.messages.create(body: 'Test', user: other_user) }
      get chat_path(other_user)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders chat template' do
      expect(response).to render_template(:chat)
    end
  end

  describe 'POST /:other_user_id (new conversation)' do
    let(:params) { { message: 'This is a new message' } }

    it 'returns http success' do
      post message_path(other_user), params: params
      expect(response).to redirect_to(chat_path(other_user))
    end

    it 'creates a new instance of conversation' do
      expect { post message_path(other_user), params: params }.to change { Conversation.all.length }.by(1)
    end

    it 'creates a new instance of message' do
      expect { post message_path(other_user), params: params }.to change { Message.all.length }.by(1)
    end
  end

  describe 'POST /:other_user_id (old conversation)' do
    let(:params) { { message: 'This is a new message' } }

    before do
      conversation = Conversation.create(user_one: user, user_two: other_user)
      2.times { conversation.messages.create(body: 'Test', user: user) }
      2.times { conversation.messages.create(body: 'Test', user: other_user) }
    end

    it 'will not create a new instance of conversation' do
      expect { post message_path(other_user), params: params }.to change { Conversation.all.length }.by(0)
    end

    it 'still creates a new instance of message' do
      expect { post message_path(other_user), params: params }.to change { Message.all.length }.by(1)
    end
  end
end

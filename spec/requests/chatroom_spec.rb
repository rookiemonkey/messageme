require 'rails_helper'

RSpec.describe 'Chatrooms', type: :request do
  let(:user) { create(:user) }

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
end

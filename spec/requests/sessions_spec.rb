require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }

  describe 'GET /signin sessions#new' do
    before { get session_new_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /signin sessions#create' do
    before { login(user) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a user session' do
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe 'DELETE /signin sessions#destroy' do
    before do
      login(user)
      delete session_destroy_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns destroys user session' do
      expect(session[:user_id]).to eq(nil)
    end
  end
end

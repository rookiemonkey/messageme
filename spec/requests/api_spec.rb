require 'rails_helper'

RSpec.describe 'Apis', type: :request do
  let(:user) { create(:user) }
  let(:user_one) { create(:user) }
  let(:user_two) { create(:user) }

  before { login(user) }

  describe 'GET /api/users' do
    before { get api_users_path, params: { username: user_one.username } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns 1 matching user from the database' do
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET /signup registrations#new' do
    before { get registration_new_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /signup registrations#create' do
    before { post registration_create_path, params: { user: attributes_for(:user) } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'creates user resource' do
      expect(User.all.length).to eq(1)
    end
  end
end

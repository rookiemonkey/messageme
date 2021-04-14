require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { create(:message) }

  context 'when saving without body' do
    before do
      message.body = nil
      message.save
    end

    it '1. should not save without body' do
      expect(message).not_to be_valid
    end

    it '2. should only have one error' do
      expect(message.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for body' do
      expect(message.errors.to_hash.keys).to include(:body)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end

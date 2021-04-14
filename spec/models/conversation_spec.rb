require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:conversation) { create(:conversation) }

  context 'when saving without user_one' do
    before do
      conversation.user_one = nil
      conversation.save
    end

    it '1. should not save without user_one' do
      expect(conversation).not_to be_valid
    end

    it '2. should only have one error' do
      expect(conversation.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for user_one' do
      expect(conversation.errors.to_hash.keys).to include(:user_one)
    end
  end

  context 'when saving without user_two' do
    before do
      conversation.user_two = nil
      conversation.save
    end

    it '1. should not save without user_two' do
      expect(conversation).not_to be_valid
    end

    it '2. should only have one error' do
      expect(conversation.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for user_two' do
      expect(conversation.errors.to_hash.keys).to include(:user_two)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user_one) }
    it { is_expected.to belong_to(:user_two) }
    it { is_expected.to have_many(:messages) }
  end
end

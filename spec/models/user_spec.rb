require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { described_class.new }

  before do
    user.username = 'Jane'
    user.password = '12345678'
    user.save
  end

  context 'when saving without username' do
    before do
      user.username = nil
      user.save
    end

    it '1. should not save without username' do
      expect(user).not_to be_valid
    end

    it '2. should only have two errors' do
      expect(user.errors.full_messages.length).to eq(2)
    end

    it '3. should only have an error for username' do
      expect(user.errors.to_hash.keys).to include(:username)
    end
  end

  context 'when saving with username with length < 3' do
    before do
      user.username = 'a' * 2
      user.save
    end

    it '1. should not save with username length < 3' do
      expect(user).not_to be_valid
    end

    it '2. should only have one error' do
      expect(user.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for username' do
      expect(user.errors.to_hash.keys).to include(:username)
    end
  end

  context 'when saving with username with length > 15' do
    before do
      user.username = 'a' * 16
      user.save
    end

    it '1. should not save with username length > 15' do
      expect(user).not_to be_valid
    end

    it '2. should only have one error' do
      expect(user.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for username' do
      expect(user.errors.to_hash.keys).to include(:username)
    end
  end

  context 'when saving with username that is duplicated' do
    let(:duplicate_user) { described_class.create(username: 'Jane', password: '987654321') }

    it '1. should not save with duplicated username' do
      expect(duplicate_user).not_to be_valid
    end

    it '2. should only have one error' do
      expect(duplicate_user.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for username' do
      expect(duplicate_user.errors.to_hash.keys).to include(:username)
    end
  end

  context 'when saving without password' do
    before do
      user.password = nil
      user.save
    end

    it '1. should not save without password' do
      expect(user).not_to be_valid
    end

    it '2. should only have one error' do
      expect(user.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for password' do
      expect(user.errors.to_hash.keys).to include(:password)
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:messages) }
  end
end

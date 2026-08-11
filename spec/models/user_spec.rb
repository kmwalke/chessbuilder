require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'requires a name' do
      expect(described_class.create(name: '').errors).to have_key(:name)
    end

    it 'requires an email' do
      expect(described_class.create(email: '').errors).to have_key(:email)
    end

    it 'requires email uniqueness' do
      user = create(:user)
      expect { create(:user, email: user.email) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'requires a role' do
      expect(described_class.create(role: '').errors).to have_key(:role)
    end

    it 'requires a level' do
      expect(described_class.create(level: '').errors).to have_key(:level)
    end
  end

  describe 'defaults' do
    let(:user) { create(:user) }

    it 'role' do
      expect(user.role).to eq(User::USER)
    end

    it 'level' do
      expect(user.level).to eq(0)
    end

    it 'deck' do
      expect(user.deck).to be_a(Deck)
    end
  end
end

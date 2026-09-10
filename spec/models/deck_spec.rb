require 'rails_helper'

RSpec.describe Deck do
  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end

  describe 'defaults' do
    let(:deck) { create(:deck) }

    it 'provisions the deck' do
      expect(deck.piece_cards.count).to eq(16)
    end
  end

  it 'delegates size' do
    deck = create(:deck)
    expect(deck.size).to eq(deck.piece_cards.size)
  end
end

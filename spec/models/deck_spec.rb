require 'rails_helper'

RSpec.describe Deck do
  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end

  describe 'defaults' do
    let(:deck) { create(:deck) }

    it 'piece_cards' do
      expect(deck.piece_cards.first).to be_a(PieceCard)
    end
  end
end

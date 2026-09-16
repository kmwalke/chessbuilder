require 'rails_helper'

RSpec.describe Deck do
  let(:deck) { create(:deck) }

  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end

  describe 'defaults' do
    it 'provisions the deck' do
      expect(deck.piece_cards.count).to eq(16)
    end
  end

  it 'delegates size' do
    expect(deck.size).to eq(deck.piece_cards.size)
  end

  describe 'calculates deck strength' do
    it 'default' do
      expect(deck.strength).to eq(16)
    end

    it 'upgraded' do
      deck.piece_cards[9].update(level: 2, rank: 3)
      deck.piece_cards[12].update(level: 2, rank: 4)
      deck.piece_cards[13].update(level: 2, rank: 5)
      deck.piece_cards[15].update(level: 2, rank: 5)
      expect(deck.strength).to eq(46)
    end

    it 'max level' do
      deck.piece_cards.each do |pc|
        pc.update(level: 2, rank: 5)
      end
      expect(deck.strength).to eq(160)
    end
  end
end

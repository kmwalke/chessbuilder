require 'rails_helper'

RSpec.describe Game do
  let(:game) { create(:game) }

  it 'displays a name' do
    expect(game.name).to eq("#{game.host.name} VS #{game.guest.name} - #{game.created_at.to_fs(:long_ordinal)}")
  end

  describe 'valid moves' do
    it 'lists valid moves' do
      piece = game.pieces.find_by(piece_card: PieceCard.find_by(name: PieceCard::KING), player: Piece::GUEST)
      piece.update(position: 'd4')

      expect(game.valid_moves(piece)).to eq(%w[e3 e5 c3 c5 e4 d3 c4 d5])
    end

    it 'doesn\'t list your own pieces as valid move' do
      piece = game.pieces.find_by(piece_card: PieceCard.find_by(name: PieceCard::KING), player: Piece::GUEST)
      piece.update(position: 'd6')

      expect(game.valid_moves(piece)).to eq(%w[e5 c5 e6 d5 c6])
    end
  end
end

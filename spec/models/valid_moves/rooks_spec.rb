require 'rails_helper'
require './spec/models/valid_moves/helper'

RSpec.describe 'Game' do
  describe 'valid moves' do
    let!(:guest) { create(:user) }
    let!(:host) { create(:user) }
    let!(:game) { create(:game, host:, guest:) }

    before do
      game.pieces.destroy_all
    end

    describe 'rooks' do
      before do
        setup_board(
          {
            Game::HOST =>
              {
                c1: PieceCard::ROOK,
                c2: PieceCard::PAWN,
                e3: PieceCard::ROOK
              },
            Game::GUEST =>
              {
                c5: PieceCard::ROOK,
                d5: PieceCard::PAWN,
                e5: PieceCard::PAWN,
                g5: PieceCard::ROOK,
                g7: PieceCard::PAWN
              }
          }
        )
        game.reload
      end

      it 'c1' do
        expect(moves_from('c1')).to eq(%w[a1 b1 d1 e1 f1 g1 h1])
      end

      it 'e3' do
        expect(moves_from('e3')).to eq(%w[a3 b3 c3 d3 e1 e2 e4 e5 f3 g3 h3])
      end

      it 'c5' do
        expect(moves_from('c5')).to eq(%w[a5 b5 c2 c3 c4 c6 c7 c8])
      end

      it 'g5' do
        expect(moves_from('g5')).to eq(%w[f5 g1 g2 g3 g4 g6 h5])
      end
    end
  end
end

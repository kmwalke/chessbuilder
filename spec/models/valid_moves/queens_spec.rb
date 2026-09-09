require 'rails_helper'
require './spec/models/valid_moves/vm_helper'

RSpec.describe 'Game' do
  describe 'valid moves' do
    let!(:guest) { create(:user) }
    let!(:host) { create(:user) }
    let!(:game) { create(:game, host:, guest:) }

    before do
      game.pieces.destroy_all
    end

    describe 'queens' do
      before do
        setup_board(
          {
            Game::HOST =>
              {
                a4: PieceCard::PAWN,
                c2: PieceCard::QUEEN,
                e4: PieceCard::QUEEN,
                h2: PieceCard::PAWN
              },
            Game::GUEST =>
              {
                a6: PieceCard::PAWN,
                c6: PieceCard::QUEEN,
                f4: PieceCard::PAWN,
                h6: PieceCard::QUEEN
              }
          }
        )
        game.reload
      end

      it 'c2' do
        expect(moves_from('c2')).to eq(%w[a2 b1 b2 b3 c1 c3 c4 c5 c6 d1 d2 d3 e2 f2 g2])
      end

      it 'e4' do
        expect(moves_from('e4')).to eq(%w[b4 c4 c6 d3 d4 d5 e1 e2 e3 e5 e6 e7 e8 f3 f4 f5 g2 g6 h1 h7])
      end

      it 'c6' do
        expect(moves_from('c6')).to eq(%w[a4 a8 b5 b6 b7 c2 c3 c4 c5 c7 c8 d5 d6 d7 e4 e6 e8 f6 g6])
      end

      it 'h6' do
        expect(moves_from('h6')).to eq(%w[d6 e6 f6 f8 g5 g6 g7 h2 h3 h4 h5 h7 h8])
      end
    end
  end
end

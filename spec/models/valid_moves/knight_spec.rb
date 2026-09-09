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

    describe 'knights' do
      before do
        setup_board(
          {
            Game::HOST =>
              {
                c3: PieceCard::PAWN,
                e2: PieceCard::KNIGHT,
                f4: PieceCard::KNIGHT
              },
            Game::GUEST =>
              {
                b6: PieceCard::KNIGHT,
                d4: PieceCard::PAWN,
                d5: PieceCard::PAWN,
                f8: PieceCard::PAWN,
                g6: PieceCard::KNIGHT
              }
          }
        )
        game.reload
      end

      it 'e2' do
        expect(moves_from('e2')).to eq(%w[c1 d4 g1 g3])
      end

      it 'f4' do
        expect(moves_from('f4')).to eq(%w[d3 d5 e6 g2 g6 h3 h5])
      end

      it 'b6' do
        expect(moves_from('b6')).to eq(%w[a4 a8 c4 c8 d7])
      end

      it 'g6' do
        expect(moves_from('g6')).to eq(%w[e5 e7 f4 h4 h8])
      end
    end
  end
end

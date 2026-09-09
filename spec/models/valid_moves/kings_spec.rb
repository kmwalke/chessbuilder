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

    describe 'kings' do
      before do
        setup_board(
          {
            Game::HOST =>
              {
                b4: PieceCard::PAWN,
                c4: PieceCard::KING,
                d2: PieceCard::KING,
                d3: PieceCard::PAWN
              },
            Game::GUEST =>
              {
                c5: PieceCard::KING,
                d6: PieceCard::KING,
                e6: PieceCard::PAWN
              }
          }
        )
        game.reload
      end

      it 'c4' do
        expect(moves_from('c4')).to eq(%w[b3 b5 c3 c5 d4 d5])
      end

      it 'd2' do
        expect(moves_from('d2')).to eq(%w[c1 c2 c3 d1 e1 e2 e3])
      end

      it 'c5' do
        expect(moves_from('c5')).to eq(%w[b4 b5 b6 c4 c6 d4 d5])
      end

      it 'd6' do
        expect(moves_from('d6')).to eq(%w[c6 c7 d5 d7 e5 e7])
      end
    end
  end
end

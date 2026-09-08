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

    describe 'pawns' do
      before do
        setup_board(
          {
            Game::HOST =>
              {
                c4: PieceCard::PAWN,
                d4: PieceCard::PAWN,
                e4: PieceCard::PAWN
              },
            Game::GUEST =>
              {
                c5: PieceCard::PAWN,
                d5: PieceCard::PAWN
              }
          }
        )
        game.reload
      end

      it 'c4' do
        expect(moves_from('c4')).to eq(%w[d5])
      end

      it 'd4' do
        expect(moves_from('d4')).to eq(%w[c5])
      end

      it 'e4' do
        expect(moves_from('e4')).to eq(%w[d5 e5])
      end

      it 'c5' do
        expect(moves_from('c5')).to eq(%w[d4])
      end

      it 'd5' do
        expect(moves_from('d5')).to eq(%w[c4 e4])
      end
    end
  end
end

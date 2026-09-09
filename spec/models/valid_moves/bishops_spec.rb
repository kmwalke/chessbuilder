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

    describe 'bishops' do
      before do
        setup_board(
          {
            Game::HOST =>
              {
                a3: PieceCard::PAWN,
                b2: PieceCard::BISHOP,
                d3: PieceCard::BISHOP,
                e4: PieceCard::PAWN
              },
            Game::GUEST =>
              {
                b5: PieceCard::PAWN,
                c6: PieceCard::BISHOP,
                d7: PieceCard::PAWN,
                f6: PieceCard::BISHOP,
                g5: PieceCard::PAWN
              }
          }
        )
        game.reload
      end

      it 'b2' do
        expect(moves_from('b2')).to eq(%w[a1 c1 c3 d4 e5 f6])
      end

      it 'd3' do
        expect(moves_from('d3')).to eq(%w[b1 b5 c2 c4 e2 f1])
      end

      it 'c6' do
        expect(moves_from('c6')).to eq(%w[a8 b7 d5 e4])
      end

      it 'f6' do
        expect(moves_from('f6')).to eq(%w[b2 c3 d4 d8 e5 e7 g7 h8])
      end
    end
  end
end

require 'rails_helper'
require './spec/requests/requests_helper'

RSpec.describe 'Rules' do
  let!(:guest) { create(:user) }
  let!(:current_user) { login }
  let!(:game) { create(:game, host: current_user, guest:) }

  before do
    visit games_path
  end

  describe 'generic chess rules' do
    pending 'En Passante'
    pending 'Castling'
    pending 'Check for other odd chess rules'

    describe 'no cheating with request spoofing' do
      it 'no illegal moves' do
        move_piece_request(game, 'd2e6')

        expect(game.pieces.find_by(position: 'd2')).to be_a(Piece)
      end

      it 'no double moves' do
        move_piece_request(game, 'd2d4')
        move_piece_request(game, 'a2a3')

        expect(game.pieces.find_by(position: 'a2')).to be_a(Piece)
      end
    end

    it 'updates has_moved?' do
      move_piece_request(game, 'a2a3')

      expect(game.pieces.find_by(position: 'a3').has_moved?).to be(true)
    end

    describe 'check' do
      before do
        move_piece_request(game, 'e2e3')
        move_piece_request(game, 'd7d6')
        move_piece_request(game, 'f1b5')
      end

      it 'marks game as in check' do
        expect(game.reload.check).to be true
      end

      it 'forces guest to move out of check' do
        skip('not implemented')
      end

      describe 'moves out of check' do
        before do
          move_piece_request(game, 'c8d7')
        end

        it 'is no longer in check' do
          expect(game.reload.check).to be false
        end
      end
    end

    describe 'pawns' do
      it 'moves 2 spaces at beginning' do
        expect(game.valid_moves(game.pieces.find_by(position: 'd2'))).to eq(%w[d3 d4])
      end

      it 'moves 1 space after first movement' do
        move_piece_request(game, 'd2d4')
        move_piece_request(game, 'a7a6')
        expect(game.valid_moves(game.pieces.find_by(position: 'd4'))).to eq(%w[d5])
      end

      it 'attack diagonally' do
        move_piece_request(game, 'd2d4')
        move_piece_request(game, 'e7e5')
        expect(game.valid_moves(game.pieces.find_by(position: 'd4'))).to eq(%w[d5 e5])
      end

      it 'can\'t attack straight ahead' do
        move_piece_request(game, 'd2d4')
        move_piece_request(game, 'd7d5')
        expect(game.valid_moves(game.pieces.find_by(position: 'd4'))).to eq(%w[])
      end
    end
  end
end

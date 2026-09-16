require 'rails_helper'
require './spec/requests/requests_helper'

RSpec.describe 'Rules' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  describe 'logged in' do
    let!(:current_user) { login }
    let!(:game) { create(:game, host: current_user, guest: user2) }

    before do
      visit games_path
    end

    describe 'test generic chess rules here' do
      # TODO: En passante, dear god
      # TODO: Castling???  Dual piece movement!!! :barf
      # TODO: Check for other chess rules
      # TODO: Break up in sections for each piece?
      # TODO: Get original pieces up and running fully before making new pieces

      describe 'no cheating with request spoofing' do
        it 'no illegal moves' do
          skip('not implemented')
          move_piece(game, 'd2e6')

          expect(game.pieces.find_by(position: 'd2')).to be_a(Piece)
        end

        it 'no double moves' do
          skip('not implemented')
          move_piece(game, 'd2d4')
          move_piece(game, 'a2a3')

          expect(game.pieces.find_by(position: 'a2')).to be_a(Piece)
        end
      end

      it 'updates has_moved?' do
        move_piece(game, 'a2a3')

        expect(game.pieces.find_by(position: 'a3').has_moved?).to be(true)
      end

      describe 'pawns' do
        it 'moves 2 spaces at beginning' do
          expect(game.valid_moves(game.pieces.find_by(position: 'd2'))).to eq(%w[d3 d4])
        end

        it 'moves 1 space after first movement' do
          move_piece(game, 'd2d4')
          move_piece(game, 'a7a6')
          expect(game.valid_moves(game.pieces.find_by(position: 'd4'))).to eq(%w[d5])
        end

        it 'attack diagonally' do
          move_piece(game, 'd2d4')
          move_piece(game, 'e7e5')
          expect(game.valid_moves(game.pieces.find_by(position: 'd4'))).to eq(%w[d5 e5])
        end

        it 'can\'t attack straight ahead' do
          move_piece(game, 'd2d4')
          move_piece(game, 'd7d5')
          expect(game.valid_moves(game.pieces.find_by(position: 'd4'))).to eq(%w[])
        end
      end
    end
  end
end

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

    describe 'test generic chess rules here', skip: 'working on it' do
      # TODO: Check that enemy pieces block travel, but can be captured
      # TODO: Check that friendly pieces block travel, but can't be captured
      # TODO: Diagonal attacks from pawns
      # TODO: En passante, dear god
      # TODO: Castling???  Dual piece movement!!! :barf
      # TODO: Pawns moving twice at the opening
      # TODO: Check for other chess rules
      # TODO: Break up in sections for each piece?
      # TODO: Get original pieces up and running fully before making new pieces

      describe 'pawns' do
        it 'moves 2 spaces at beginning' do
          expect(game.valid_moves(game.pieces.find_by(position: 'd2'))).to eq(%w[d3 d4])
        end

        it 'moves 1 space after first movement' do
          move_piece(game, 'd2d4')
        end

        it 'attack diagonally' do
        end

        it 'can\'t attack straight ahead' do
        end
      end
    end
  end
end

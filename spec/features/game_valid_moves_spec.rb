require 'rails_helper'

RSpec.feature 'Game Valid Moves' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  describe 'logged in' do
    let!(:current_user) { login }
    let!(:game) { create(:game, host: current_user, guest: user2) }

    before do
      visit games_path
    end

    it 'checks valid moves' do
      skip('TODO')
      # TODO: simulate specific board setups
      #   start with empty board
      #   place some pieces in the center of the board
      #   check that game.valid_moves is correct for each piece
    end
  end
end

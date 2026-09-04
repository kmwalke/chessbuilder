require 'rails_helper'

RSpec.feature 'Rules' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  describe 'logged in' do
    let!(:current_user) { login }
    let!(:game) { create(:game, host: current_user, guest: user2) }

    before do
      visit games_path
    end

    it 'test generic chess rules here' do
      skip('list ideas here')
      # TODO: Check that enemy pieces block travel, but can be captured
      # TODO: Check that friendly pieces block travel, but can't be captured
      # TODO: Diagonal attacks from pawns
      # TODO: En passante, dear god
      # TODO: Pawns moving twice at the opening
      # TODO: Check for other chess rules
      # TODO: Break up in sections for each piece?
      # TODO: Get original pieces up and running fully before making new pieces
    end
  end
end

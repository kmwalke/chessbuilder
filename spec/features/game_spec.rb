require 'rails_helper'

RSpec.feature 'Games' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:game) { create(:game, host: user1, guest: user2) }

  before do
    3.times do
      user1.deck.piece_cards << create(:piece_card)
      user2.deck.piece_cards << create(:piece_card)
    end
  end

  describe 'Logged out' do
    before do
      visit games_path
    end

    it 'shows the games' do
      expect(page).to have_text(game.name)
    end

    it 'views a game' do
      click_link(game.name)
      expect(page).to have_current_path(game_path(game))
    end

    it 'cant start a game' do
      expect(page).to have_no_text('New Game')
    end
  end

  describe 'logged in' do
    let!(:current_user) { login }
    let!(:game) { create(:game, host: current_user, guest: user2) }

    before do
      visit games_path
    end

    it 'shows my games' do
      skip('not implemented')
    end

    describe 'starts a game' do
      before do
        skip('not implemented')
        click_link 'New Game'
        select user1.name, from: 'user-dropdown'
        click_link 'Start Game'
      end

      it 'redirects to the game page' do
      end

      it 'sets up the board' do
      end
    end

    describe 'rejoins a game' do
      before do
        click_link game.name
      end

      it 'redirects to the game page' do
        expect(page).to have_current_path(game_path(game))
      end
    end
  end
end

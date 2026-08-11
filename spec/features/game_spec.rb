require 'rails_helper'

RSpec.feature 'Games' do
  let!(:user) { create(:user) }

  before do
    3.times do
      user.deck.piece_cards << create(:piece_card)
    end
  end

  describe 'Logged out' do
    before do
      visit games_path
    end

    it 'shows the games' do
      skip('not implemented')
    end

    it 'views a game' do
      skip('not implemented')
    end

    it 'cant start a game' do
      expect(page).to have_no_text('New Game')
    end
  end

  describe 'logged in' do
    let!(:current_user) { login }

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
      end

      it 'redirects to the game page' do
      end

      it 'sets up the board' do
      end
    end

    it 'rejoins a game' do
      skip('not implemented')
    end
  end
end

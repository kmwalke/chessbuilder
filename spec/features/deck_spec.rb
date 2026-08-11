require 'rails_helper'

RSpec.feature 'Decks' do
  let!(:user) { create(:user) }

  before do
    3.times do
      user.deck.piece_cards << create(:piece_card)
    end
  end

  describe 'Logged out' do
    before do
      visit users_path
    end

    describe 'shows a user\'s deck' do
      before do
        click_link user.name
      end

      it 'shows the user deck' do
        user.deck.piece_cards.each do |card|
          expect(page).to have_text(card.name)
        end
      end
    end
  end

  describe 'logged in' do
    before do
      login
      visit users_path
    end

    describe 'edits a deck' do
      it 'updates the deck' do
        skip('not implemented')
        expect(user.reload.name).to eq(new_user.name)
      end
    end
  end
end

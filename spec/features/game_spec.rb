require 'rails_helper'

RSpec.feature 'Games' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  describe 'Logged out' do
    let!(:game) { create(:game, host: user1, guest: user2) }

    before do
      visit games_path
    end

    it 'shows the games' do
      expect(page).to have_text(game.name)
    end

    describe 'views a game' do
      before do
        click_link(game.name)
      end

      it 'redirects' do
        expect(page).to have_current_path(game_path(game))
      end

      it 'shows the name' do
        expect(page).to have_text("#{user1.name}'s turn")
      end
    end

    it 'cant start a game' do
      expect(page).to have_no_text('New Game')
    end
  end

  describe 'logged in' do
    let!(:current_user) { login }
    let!(:game) { create(:game, host: current_user, guest: user2) }
    let!(:other_game) { create(:game) }

    before do
      visit games_path
    end

    describe 'displays games' do
      it 'shows my games' do
        expect(page).to have_text(game.name)
      end

      it 'doesn\'t show other games' do
        expect(page).to have_no_text(other_game.name)
      end

      it 'shows other games when requested' do
        click_link 'View all games'

        expect(page).to have_text(other_game.name)
      end

      it 'shows games you lost' do
        game.update(winner: game.guest)
        visit games_path

        expect(page).to have_text("Lost - #{game.name}")
      end

      it 'shows games you won' do
        game.update(winner: current_user)
        visit games_path

        expect(page).to have_text("Won - #{game.name}")
      end
    end

    describe 'starts a game' do
      before do
        click_link 'New game'
        select user1.name, from: 'game_guest_id'
        click_button 'Create Game'
      end

      it 'redirects to the game page' do
        expect(page).to have_current_path(game_path(Game.last))
      end

      it 'assigns the pieces' do
        expect(Game.last.pieces.count).to eq(user1.deck.piece_cards.count + current_user.deck.piece_cards.count)
      end

      it 'sets up the host pieces on the board' do
        Game.last.pieces.host.each do |piece|
          expect(piece.start_positions.include?(piece.position)).to be true
        end
      end

      it 'sets up the guest pieces on the board' do
        Game.last.pieces.guest.each do |piece|
          expect(piece.start_positions.include?(convert_to_guest(piece.position))).to be true
        end
      end

      it 'sets the host as current player' do
        expect(Game.last.current_player).to eq(current_user)
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

  private

  def convert_to_guest(position)
    "#{position[0]}#{9 - position[1].to_i}"
  end
end

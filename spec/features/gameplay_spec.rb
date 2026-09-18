require 'rails_helper'

RSpec.feature 'Gameplay' do
  let!(:current_player) { login }
  let!(:game) { create(:game, host: current_player, current_player:) }

  before do
    visit game_path(game)
  end

  describe 'cheating' do
    it 'doesn\'t move the other players pieces' do
      piece = game.pieces.guest.first
      expect { page.find_by_id("#{piece.position}_piece_select") }.to raise_error(Capybara::ElementNotFound)
    end

    it 'doesn\'t go twice' do
      skip('not implemented')
    end

    it 'doesn\'t make an illegal move' do
      skip('not implemented')
    end
  end

  describe 'bad input' do
    it 'must select a piece' do
      click_button 'Move piece'
      expect(page).to have_text(ErrorMessages::BAD_INPUT[:select_piece])
    end

    it 'must select a move' do
      page.find_by_id('d2_piece_select').click
      click_button 'Move piece'
      expect(page).to have_text(ErrorMessages::BAD_INPUT[:select_move])
    end
  end

  describe 'moves a piece' do
    let!(:piece) { game.pieces.find_by(position: 'd2') }

    before do
      page.find_by_id('d2_piece_select').click
      page.find_by_id('d2d3_move_select').click
      click_button 'Move piece'
    end

    it 'updates the piece position' do
      expect(piece.reload.position).to eq('d3')
    end

    it 'switches turns to the guest' do
      expect(game.reload.current_player).to eq(game.guest)
    end
  end

  describe 'moves a piece far' do
    let!(:queen) { game.pieces.find_by(position: 'd1') }
    let!(:pawn) { game.pieces.find_by(position: 'd2') }

    before do
      pawn.destroy
      visit game_path(game)
      page.find_by_id('d1_piece_select').click
      page.find_by_id('d1d7_move_select').click
      click_button 'Move piece'
    end

    it 'updates the piece position' do
      expect(queen.reload.position).to eq('d7')
    end

    it 'switches turns to the guest' do
      expect(game.reload.current_player).to eq(game.guest)
    end
  end

  describe 'captures a piece' do
    let!(:piece) { game.pieces.find_by(position: 'd2') }
    let!(:captured_piece) { game.pieces.find_by(position: 'c7') }
    let!(:captured_piece_id) { captured_piece.id }

    before do
      piece.update(position: 'd6')
      visit game_path(game)

      page.find_by_id('d6_piece_select').click
      page.find_by_id('d6c7_move_select').click
      click_button 'Move piece'
    end

    it 'deletes the captured piece' do
      expect(Piece.find_by(id: captured_piece_id)).to be_nil
    end

    it 'updates the piece position' do
      expect(piece.reload.position).to eq('c7')
    end

    it 'capturing player gets resources for the piece' do
      expect(current_player.reload.upgrade_points).to eq(1)
    end
  end
end

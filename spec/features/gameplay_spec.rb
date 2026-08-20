require 'rails_helper'

RSpec.feature 'Gameplay' do
  let!(:current_user) { login }
  let!(:game) { create(:game, host: current_user) }

  before do
    visit game_path(game)
  end

  describe 'moves a piece' do
    let!(:piece) { game.pieces.find_by(position: 'e7') }

    before do
      page.find_by_id('e7_piece_select').click
      page.find_by_id('e6_move_select').click
      click_button 'Move piece'
    end

    it 'updates the piece position' do
      expect(piece.reload.position).to eq('e6')
    end
  end

  describe 'captures a piece' do
    let!(:piece) { game.pieces.find_by(position: 'e7') }
    let!(:captured_piece_id) { game.pieces.find_by(position: 'e2').id }

    before do
      piece.update(position: 'e3')
      visit game_path(game)

      page.find_by_id('e3_piece_select').click
      page.find_by_id('e2_move_select').click
      click_button 'Move piece'
    end

    it 'deletes the captured piece' do
      expect(Piece.find_by(id: captured_piece_id)).to be_nil
    end

    it 'updates the piece position' do
      expect(piece.reload.position).to eq('e2')
    end
  end
end

require 'rails_helper'

RSpec.feature 'Gameplay' do
  let!(:current_user) { login }
  let!(:game) { create(:game, host: current_user, current_player: current_user) }

  before do
    visit game_path(game)
  end

  it 'doesn\'t move the other players pieces' do
    piece = game.pieces.guest.first
    expect { page.find_by_id("#{piece.position}_piece_select") }.to raise_error(Capybara::ElementNotFound)
  end

  describe 'moves a piece' do
    let!(:piece) { game.pieces.find_by(position: 'd2') }

    before do
      page.find_by_id('d2_piece_select').click
      page.find_by_id('d3_move_select').click
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
    skip('not implemented')
  end

  describe 'captures a piece' do
    let!(:piece) { game.pieces.find_by(position: 'd2') }
    let!(:captured_piece_id) { game.pieces.find_by(position: 'd7').id }

    before do
      piece.update(position: 'd6')
      visit game_path(game)

      page.find_by_id('d6_piece_select').click
      page.find_by_id('d7_move_select').click
      click_button 'Move piece'
    end

    it 'deletes the captured piece' do
      expect(Piece.find_by(id: captured_piece_id)).to be_nil
    end

    it 'updates the piece position' do
      expect(piece.reload.position).to eq('d7')
    end
  end
end

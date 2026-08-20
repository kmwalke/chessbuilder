require 'rails_helper'

RSpec.feature 'Gameplay' do
  let!(:current_user) { login }
  let!(:game) { create(:game, host: current_user) }

  before do
    visit game_path(game)
  end

  it 'moves a piece' do
    piece = game.pieces.find_by(position: 'e7')
    page.find_by_id('e7_piece_select').click
    page.find_by_id('e6_move_select').click
    click_button 'Move piece'

    expect(piece.reload.position).to eq('e6')
  end

  it 'captures a piece' do
    piece = game.pieces.find_by(position: 'e7')
    piece.update(position: 'e3')
    visit game_path(game)

    captured_piece_id = game.pieces.find_by(position: 'e2').id

    page.find_by_id('e3_piece_select').click
    page.find_by_id('e2_move_select').click
    click_button 'Move piece'

    expect(Piece.find_by(id: captured_piece_id)).to be_nil
  end
end

require 'rails_helper'

RSpec.feature 'PieceCards' do
  let!(:piece_card) { create(:piece_card) }

  before do
    visit piece_cards_path
  end

  it 'displays the page' do
    expect(page).to have_current_path(piece_cards_path)
  end

  it 'shows the piece cards' do
    expect(page).to have_text(piece_card.name)
  end
end

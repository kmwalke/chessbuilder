require 'rails_helper'

RSpec.feature 'Navigation' do
  before do
    login
  end

  it 'navigates home' do
    visit users_path
    click_link 'Home'

    expect(page).to have_current_path(root_path)
  end

  it 'navigates to games' do
    click_link 'Games'

    expect(page).to have_current_path(games_path)
  end

  it 'navigates to users' do
    click_link 'Users'

    expect(page).to have_current_path(users_path)
  end

  it 'navigates to piece_cards' do
    click_link 'Piece Cards'

    expect(page).to have_current_path(piece_cards_path)
  end
end

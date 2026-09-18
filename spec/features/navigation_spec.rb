require 'rails_helper'

RSpec.feature 'Navigation' do
  before do
    login
  end

  it 'navigates home' do
    visit users_path
    within '.header' do
      click_link 'Home'
    end

    expect(page).to have_current_path(root_path)
  end

  it 'navigates to games' do
    within '.header' do
      click_link 'Games'
    end

    expect(page).to have_current_path(games_path)
  end

  it 'navigates to users' do
    within '.header' do
      click_link 'Users'
    end

    expect(page).to have_current_path(users_path)
  end

  it 'navigates to piece_cards' do
    within '.header' do
      click_link 'Piece Cards'
    end

    expect(page).to have_current_path(piece_cards_path)
  end
end

require 'rails_helper'

RSpec.describe 'Sessions' do
  describe 'logged out' do
    it 'redirects to login page' do
      visit edit_user_path(create(:user))
      expect(page).to have_current_path(login_path, ignore_query: true)
    end
  end

  describe 'typos' do
    let(:user) { create(:user) }

    before do
      visit login_path
    end

    it 'logs in with caps' do
      fill_in 'Email', with: user.email.upcase
      fill_in 'Password', with: user.password
      click_button 'Log In'

      expect(page).to have_text('Log Out')
    end

    it 'logs in with spaces' do
      fill_in 'Email', with: "   #{user.email}  "
      fill_in 'Password', with: user.password
      click_button 'Log In'

      expect(page).to have_text('Log Out')
    end
  end

  describe 'logged in' do
    before do
      login
    end

    it 'logs in' do
      expect(page).to have_text('Log Out')
    end

    it 'logs out' do
      logout
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end
end

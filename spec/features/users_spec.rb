require 'rails_helper'

RSpec.feature 'Users' do
  let!(:admin) { create(:user, role: User::ADMIN) }
  let!(:user) { create(:user) }

  describe 'Logged out' do
    before do
      visit users_path
    end

    describe 'bad form data' do
      before do
        click_link 'New user'
        click_button 'Create User'
      end

      it 'requires name' do
        expect(page).to have_text('Name can\'t be blank')
      end

      it 'requires email' do
        expect(page).to have_text('Email can\'t be blank')
      end

      it 'requires password' do
        expect(page).to have_text('Password can\'t be blank')
      end
    end

    describe 'creates a user' do
      let(:new_user) { build(:user) }

      before do
        click_link 'New user'
        fill_form new_user
        click_button 'Create User'
      end

      it 'saves the user' do
        expect(User.last.name).to eq(new_user.name)
      end

      it 'redirects' do
        expect(page).to have_current_path(user_path(User.last))
      end
    end

    it 'lists users' do
      User.find_each do |user|
        expect(page).to have_text(user.name)
      end
    end

    describe 'shows a user' do
      before do
        click_link user.name
      end

      it 'redirects' do
        expect(page).to have_current_path(user_path(user))
      end

      it 'shows the user info' do
        expect(page).to have_text(user.name)
      end
    end
  end

  describe 'logged in' do
    before do
      login
      visit users_path
    end

    describe 'edits a user' do
      let(:new_user) { build(:user) }

      before do
        click_link user.name
        click_link 'Edit this user'
        fill_form new_user
        click_button 'Update User'
      end

      it 'redirects' do
        expect(page).to have_current_path(user_path(user))
      end

      it 'updates the user' do
        expect(user.reload.name).to eq(new_user.name)
      end
    end

    it 'deletes a user' do
      click_link user.name
      click_button 'Destroy this user'

      expect(User.where(name: user.name)).to be_empty
    end
  end

  def fill_form(new_user)
    fill_in 'Name', with: new_user.name
    fill_in 'Email', with: new_user.email
    fill_in 'Password', with: new_user.password
    fill_in 'Password confirmation', with: new_user.password
  end
end

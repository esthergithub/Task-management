require 'rails_helper'
describe 'User test', type: :system do

  describe 'User registration test' do
    context 'when you sign up' do
      it 'registers new users' do
        visit new_user_path
        fill_in "name",         with: "Example User"
        fill_in "email",        with: "user@example.com"
        fill_in "password",     with: "foobar"
        fill_in "password_confirmation", with: "foobar"
        expect{ click_button "Create User" }.to change(User, :count).by(1)
      end
    end
    context 'When the user tries to jump to the task list screen without logging in' do
      it 'transition to the login screen' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq tasks_path
      end
    end
  end

  describe 'Session functionality test' do
    before do
      FactoryBot.create(:user, name: 'user1',
                               email: 'user1@gmail.com',
                               password: 'password',
                               password_confirmation: 'password')
      visit new_session_path
      fill_in 'Email', with: 'user1@gmail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      @user = User.first
    end
    context 'to be able to login' do
      it 'enables login' do
        expect(current_path).to eq user_path(id: @user.id)
      end
    end
    context 'to be able to login' do
      it 'enables login' do
        expect(page).to have_content("Task")
      end
    end
    context 'When a general user jumps to another persons details screen' do
      it 'transition to the task list screen' do
        sue = User.create(name: 'Hi',
                                 email: 'hi@gmail.com',
                                 password: 'password',
                                 password_confirmation: 'password')
        visit user_path(id: sue.id)
        expect(page).to have_content("Tasks List")
      end
    end
  end
  describe 'Admin screen test' do
    context 'Admin users should be able to access the admin screen' do
      before do
        FactoryBot.create(:admin_user, name: 'admin',
                          email: 'admin@gmail.com',
                          password: 'password',
                          password_confirmation: 'password'
                           )
        visit new_session_path
        fill_in 'Email', with: 'admin@gmail.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        @admin_user = User.first
      end
      it 'accesses admin screen' do
        expect(page).to have_content("Users")
      end
    end
    context 'General users' do
      it 'cannot access the management screen' do
        FactoryBot.create(:user, name: 'user1',
                                 email: 'user1@gmail.com',
                                 password: 'password',
                                 password_confirmation: 'password'
                               )
        visit new_session_path
        fill_in 'Email', with: 'user1@gmail.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        @user = User.first
        visit admin_users_path
        expect(page).to have_content("Task")
      end
    end
    context 'Admin users can' do
      it 'register new users' do
        FactoryBot.create(:admin_user, name: 'admin',
                          email: 'admin@gmail.com',
                          password: 'password',
                          password_confirmation: 'password'
                           )
        visit new_session_path
        fill_in 'Email', with: 'admin@gmail.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        @admin_user = User.first
        click_on 'Create user'
        fill_in "name",         with: "Example User"
        fill_in "email",        with: "user@example.com"
        fill_in "password",     with: "foobar"
        fill_in "password_confirmation", with: "foobar"
        expect{ click_on "Submit" }.to change(User, :count).by(1)
      end
    end
    context 'Admin users should be able to' do
      it ' access the user details screen' do
        FactoryBot.create(:admin_user, name: 'admin',
                          email: 'admin@gmail.com',
                          password: 'password',
                          password_confirmation: 'password'
                           )
        visit new_session_path
        fill_in 'Email', with: 'admin@gmail.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        @admin_user = User.first
        click_on 'Show'
        expect(page).to have_content("Username")
      end
    end
    context 'Admin user can' do
      before do
        User.create(name: 'Hi',
                                 email: 'hi@gmail.com',
                                 password: 'password',
                                 password_confirmation: 'password')
        @user = User.first
      end
      it 'Edit the user from the user edit screen' do
        FactoryBot.create(:admin_user, name: 'admin',
                          email: 'admin@gmail.com',
                          password: 'password',
                          password_confirmation: 'password'
                           )
        visit new_session_path
        fill_in 'Email', with: 'admin@gmail.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        @admin_user = User.first
        click_on('Edit', match: :first)
        page.accept_confirm('Are you sure?')
        expect(current_path).to eq edit_admin_user_path(id: @user.id)
      end
    end
    context 'Admin users' do
      before do
        User.create(name: 'Hi',
                                 email: 'hi@gmail.com',
                                 password: 'password',
                                 password_confirmation: 'password')
        @user = User.first
      end
      it 'can delete users' do
        FactoryBot.create(:admin_user, name: 'admin',
                          email: 'admin@gmail.com',
                          password: 'password',
                          password_confirmation: 'password'
                           )
        visit new_session_path
        fill_in 'Email', with: 'admin@gmail.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        @admin_user = User.first
        click_on('Delete', match: :first)
        page.accept_confirm('Are you sure?')
        expect(page).not_to have_content('hi@gmail.com')
      end
    end
  end
end

require 'rails_helper'

RSpec.feature 'Sessions management', tpye: :feature do
  scenario 'User tries to login with no data' do 
    visit login_path
    expect(page).to have_current_path(login_path)
    puts page.html
    click_button 'Log in'

    expect(page).to have_text('There was something wrong with your login information')
  end

  scenario 'User tries to login with valid data' do 
    user = User.create(username: 'test_user', password: 'password', email: 'email@gmail.com')

    visit login_path
    expect(page).to have_current_path(login_path)
    puts page.html
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'Log in'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('You have logged in')
  end

  scenario 'User tries to logout when logged in' do 
    user = User.create(username: 'test_user', password: 'password', email: 'email@gmail.com')

    visit login_path
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'Log in'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('You have logged in')

    click_link 'Log out'
    expect(current_path).to eq(root_path)
    expect(page).to have_text('You have logged out')
  end
end
require 'rails_helper'

RSpec.feature 'Users CRUD', tpye: :feature do
  # Create
  scenario 'Admin can create users of both account types' do
    admin = create(:admin)
    
    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'
    
    click_link 'New user'
    expect(page).to have_text('Create new user')
    fill_in 'user_username', with: 'new_user'
    fill_in 'user_email',    with: 'new@email.com'
    fill_in 'user_password', with: 'password'
    select('team_member', :from => 'user_is_admin')
    click_button 'Create'

    user = User.last
    expect(user.username).to eq('new_user')
    expect(user.is_admin).to eq(false)

    visit new_user_path
    fill_in 'user_username', with: 'new_admin'
    fill_in 'user_email',    with: 'newadmin@email.com'
    fill_in 'user_password', with: 'password'
    select('admin', :from => 'user_is_admin')
    click_button 'Create'

    user = User.last
    expect(user.username).to eq('new_admin')
    expect(user.is_admin).to eq(true)
  end

  scenario 'Team member cannot create accounts' do
    team_member = create(:user)

    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'

    expect(page).not_to have_text('Create new user')
    visit new_user_path
    expect(page).to have_text('You are not authorised to perform that action')
  end

  # Read
  scenario 'Admin can view users of both account types' do
    admin = create(:admin)
    team_member = create(:user)

    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'
    
    visit user_path(admin)
    expect(page).to have_text(admin.username)

    visit user_path(team_member)
    expect(page).to have_text(team_member.username)
  end

  scenario 'Team members can view users of both account types' do
    admin = create(:admin)
    team_member = create(:user)

    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'
    
    visit user_path(admin)
    expect(page).to have_text(admin.username)

    visit user_path(team_member)
    expect(page).to have_text(team_member.username)
  end

  # Update
  scenario 'Admin can update their account' do
    admin = create(:admin)

    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit edit_user_path(admin)
    fill_in 'user_username', with: 'hello123'
    click_button 'Update account'

    user = User.first
    expect(user.username).to eq('hello123')
  end

  scenario 'Admin can update admin account to team member' do

  end

  scenario 'Admin can update team member to admin' do

  end

  scenario 'Team member can update their account but not their type' do

  end

  scenario 'Team member cannot update an account which is not theirs' do

  end

  # Delete
  scenario 'Admin can delete any account' do

  end

  scenario 'Admin can delete their account' do

  end

  scenario 'Team member can only delete their account' do

  end

end
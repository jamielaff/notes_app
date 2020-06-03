require 'rails_helper'

RSpec.feature 'Users CRUD', type: :feature do
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
    select 'team_member', from: 'user_is_admin'
    click_button 'Create'

    user = User.last
    expect(user.username).to eq('new_user')
    expect(user.is_admin).to eq(false)

    visit new_user_path
    fill_in 'user_username', with: 'new_admin'
    fill_in 'user_email',    with: 'newadmin@email.com'
    fill_in 'user_password', with: 'password'
    select 'admin', from: 'user_is_admin'
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
    admin     = create(:admin)
    admin_new = create(:another_admin)

    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit edit_user_path(admin_new)
    expect(page).to have_text('Edit User Account')
    select 'team_member', from: 'user_is_admin'
    click_button 'Update account'

    expect(User.last.is_admin).to eq(false)
  end

  scenario 'Admin can update team member to admin' do
    admin   = create(:admin)
    user    = create(:user)

    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit edit_user_path(user)
    expect(page).to have_text('Edit User Account')
    select 'admin', from: 'user_is_admin'
    click_button 'Update account'

    expect(User.last.is_admin).to eq(true)
  end

  scenario 'Team member can update their account but not their type' do
    user = create(:user)

    visit login_path
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'Log in'

    visit edit_user_path(user)
    expect(page).to have_text('Edit User Account')
    expect(page).not_to have_text('Account type')
  end

  scenario 'Team member cannot update an account which is not theirs' do
    user      = create(:user)
    user_new  = create(:another_user)

    visit login_path
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'Log in'

    visit edit_user_path(user_new)
    expect(page).to have_text('You are not authorised to perform that action')
  end

  # Delete
  scenario 'Admin can delete any account' do
    admin     = create(:admin)
    admin_new = create(:another_admin)
    user      = create(:user)

    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    expect(User.count).to eq(3)

    visit user_path(admin_new)
    click_link 'Delete'
    expect(page).to have_text('User was deleted')
    expect(User.count).to eq(2)

    visit user_path(user)
    click_link 'Delete'
    expect(page).to have_text('User was deleted')
    expect(User.count).to eq(1)
  end

  scenario 'Admin can delete their account' do
    admin = create(:admin)

    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit user_path(admin)
    click_link 'Delete'
    expect(page).to have_text('User was deleted')
    expect(User.count).to eq(0)
  end

  scenario 'Team member can only delete their account' do

  end

end
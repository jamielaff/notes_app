require 'rails_helper'

RSpec.feature 'Users CRUD', type: :feature, js: true do
  let!(:admin)            { create(:admin) }
  let!(:team_member)      { create(:user) }
  let!(:admin_new)        { create(:another_admin) }
  let!(:team_member_new)  { create(:another_user) }

  # Create
  scenario 'Admin can create users of both account types' do
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
    expect(page).to have_text('Created new user')

    user_team = User.last
    expect(user_team.username).to eq('new_user')
    expect(user_team.is_admin).to eq(false)

    visit new_user_path
    fill_in 'user_username', with: 'new_admin'
    fill_in 'user_email',    with: 'newadmin@email.com'
    fill_in 'user_password', with: 'password'
    select 'admin', from: 'user_is_admin'
    click_button 'Create'
    expect(page).to have_text('Created new user')

    user_admin = User.last
    expect(user_admin.username).to eq('new_admin')
    expect(user_admin.is_admin).to eq(true)
  end

  scenario 'Team member cannot create accounts' do
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
    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit edit_user_path(admin)
    fill_in 'user_username', with: 'hello123'
    click_button 'Update account'

    expect(page).to have_text('account was updated successfully')
    expect(User.first.username).to eq('hello123')
  end

  scenario 'Admin can update admin account to team member' do
    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit edit_user_path(admin_new)
    expect(page).to have_text('Edit User Account')
    select 'team_member', from: 'user_is_admin'
    click_button 'Update account'

    expect(page).to have_text('account was updated successfully')
    expect(User.last.is_admin).to eq(false)
  end

  scenario 'Admin can update team member to admin' do
    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit edit_user_path(team_member)
    expect(page).to have_text('Edit User Account')
    select 'admin', from: 'user_is_admin'
    click_button 'Update account'

    expect(page).to have_text('account was updated successfully')
    expect(User.find(team_member.id).is_admin).to eq(true)
  end

  scenario 'Team member can update their account but not their type' do
    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'

    visit edit_user_path(team_member)
    expect(page).to have_text('Edit User Account')
    expect(page).not_to have_text('Account type')

    fill_in 'user_username', with: 'test123'
    fill_in 'user_password', with: 'newPassword'
    click_button 'Update account'

    expect(page).to have_text('account was updated successfully')
  end

  scenario 'Team member cannot update an account which is not theirs' do
    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'

    visit edit_user_path(team_member_new)
    expect(page).to have_text('You are not authorised to perform that action')
  end

  # Delete
  scenario 'Admin can delete any account' do
    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    expect(User.count).to eq(4)

    visit user_path(admin_new)
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('User was deleted')
    expect(User.count).to eq(3)

    visit user_path(team_member)
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('User was deleted')
    expect(User.count).to eq(2)
  end

  scenario 'Admin can delete their account' do
    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit user_path(admin)
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('User was deleted')
    expect(User.count).to eq(3)
  end

  scenario 'Team member can only delete their account' do
    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'

    visit user_path(admin)
    expect(page).not_to have_button('Delete')

    visit user_path(team_member)
    expect(page).to have_link('Delete')

    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('User was deleted')
    # I want to expand this test, to try to actually delete the admin user as a team_member
  end

end
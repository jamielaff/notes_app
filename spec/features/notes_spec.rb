require 'rails_helper'

RSpec.feature 'Notes CRUD', type: :feature, js: true do
  let!(:team_member)      { create(:user) }
  let!(:admin)            { create(:admin) }
  let!(:team_member_note) { create(:note, user: team_member) }
  let!(:admin_note)        { create(:admin_note, user: admin) }
  # Create
  scenario 'Admin can create a note' do
    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    click_link 'Create note'
    expect(page).to have_text('Create a new note')
    fill_in 'note_title',       with: 'New note title'
    fill_in 'note_description', with: 'New note description'
    click_button 'Create Note'
    expect(page).to have_text('Note was successfully created')

    note = Note.last
    expect(note.title).to eq('New note title')
    expect(note.description).to eq ('New note description')
    expect(note.owned_by?(admin)).to eq(true)
  end

  scenario 'Team member can create a note' do
    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'

    click_link 'Create note'
    expect(page).to have_text('Create a new note')
    fill_in 'note_title',       with: 'New note title'
    fill_in 'note_description', with: 'New note description'
    click_button 'Create Note'
    expect(page).to have_text('Note was successfully created')

    note = Note.last
    expect(note.title).to eq('New note title')
    expect(note.description).to eq ('New note description')
    expect(note.owned_by?(team_member)).to eq(true)
  end

  # Read
  scenario 'Admin can view notes made by any user' do
    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit note_path(team_member_note)
    expect(page).to have_text(team_member_note.title)
    expect(page).to have_text(team_member_note.description)

    visit note_path(admin_note)
    expect(page).to have_text(admin_note.title)
    expect(page).to have_text(admin_note.description)
  end

  scenario 'Team member can view notes made by any user' do
    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'

    visit note_path(team_member_note)
    expect(page).to have_text(team_member_note.title)
    expect(page).to have_text(team_member_note.description)

    visit note_path(admin_note)
    expect(page).to have_text(admin_note.title)
    expect(page).to have_text(admin_note.description)
  end

  scenario 'User not logged in can view notes made by any user' do
    visit note_path(team_member_note)
    expect(page).to have_text(team_member_note.title)
    expect(page).to have_text(team_member_note.description)

    visit note_path(admin_note)
    expect(page).to have_text(admin_note.title)
    expect(page).to have_text(admin_note.description)
  end

  # Update
  scenario 'Admin can update any note' do
    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit edit_note_path(team_member_note)
    fill_in 'note_title',       with: 'New title 1'
    fill_in 'note_description', with: 'New description 1'
    click_button 'Update Note'
    expect(page).to have_text('Note was updated')
    expect(Note.first.title).to eq('New title 1')
    expect(Note.first.description).to eq('New description 1')

    visit edit_note_path(admin_note)
    fill_in 'note_title',       with: 'New title 2'
    fill_in 'note_description', with: 'New description 2'
    click_button 'Update Note'
    expect(page).to have_text('Note was updated')
    expect(Note.last.title).to eq('New title 2')
    expect(Note.last.description).to eq('New description 2')
  end

  scenario 'Team member can update their note' do
    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'

    visit edit_note_path(team_member_note)
    fill_in 'note_title',       with: 'New title 1'
    fill_in 'note_description', with: 'New description 1'
    click_button 'Update Note'
    expect(page).to have_text('Note was updated')
    expect(Note.first.title).to eq('New title 1')
    expect(Note.first.description).to eq('New description 1')

    
  end

  scenario 'Team member cannot update note they do not own' do
    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'

    visit edit_note_path(admin_note)
    expect(page).to have_text('You are not authorised to perform that action')
  end

  # Delete
  scenario 'Admin can delete any note' do
    expect(Note.count).to eq(2)

    visit login_path
    fill_in 'username', with: admin.username
    fill_in 'password', with: admin.password
    click_button 'Log in'

    visit edit_note_path(team_member_note)
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('Note was deleted')
    expect(Note.count).to eq(1)

    visit edit_note_path(admin_note)
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('Note was deleted')
    expect(Note.count).to eq(0)
  end

  scenario 'Team member can only delete their note' do
    expect(Note.count).to eq(2)

    visit login_path
    fill_in 'username', with: team_member.username
    fill_in 'password', with: team_member.password
    click_button 'Log in'

    visit edit_note_path(team_member_note)
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('Note was deleted')
    expect(Note.count).to eq(1)

    visit edit_note_path(admin_note)
    expect(page).not_to have_link('Delete')
    expect(Note.count).to eq(1)
  end
end
require "rails_helper"

RSpec.describe "Note requests", type: :request do
  let!(:admin)            { create(:admin) }
  let!(:team_member)      { create(:user) }
  let!(:team_member_note) { create(:note, user: team_member) }
  let!(:admin_note)       { create(:admin_note, user: admin) }

  it 'Deletes any note when logged in as admin' do
    post login_path, params: { username: admin.username, password: admin.password }

    expect(response).to redirect_to(root_path)
    expect(User.count).to eq(2)
    expect(Note.count).to eq(2)

    delete note_path(team_member_note)
    expect(response).to redirect_to(root_path)
    
    follow_redirect!
    expect(response.body).to include('Note was deleted')
    expect(Note.count).to eq(1)

    delete note_path(admin_note)
    expect(response).to redirect_to(root_path)

    follow_redirect!
    expect(response.body).to include('Note was deleted')
    expect(Note.count).to eq(0)
  end

  it 'Does not delete admin note when logged in as team_member' do
    post login_path, params: { username: team_member.username, password: team_member.password }

    expect(response).to redirect_to(root_path)
    expect(User.count).to eq(2)
    expect(Note.count).to eq(2)

    delete note_path(team_member_note)
    expect(response).to redirect_to(root_path)
    
    follow_redirect!
    expect(response.body).to include('Note was deleted')
    expect(Note.count).to eq(1)

    delete note_path(admin_note)
    expect(response).to redirect_to(root_path)

    follow_redirect!
    expect(response.body).to include('You are not authorised to perform that action')
    expect(Note.count).to eq(1)
  end
end
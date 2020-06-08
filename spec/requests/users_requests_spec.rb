require "rails_helper"

RSpec.describe "User requests" do

  context 'deleting users' do
    let!(:admin_user)     { create(:admin) }
    let!(:team_member)    { create(:user) }
    let!(:team_member_2)  { create(:another_user) }

    it 'Deletes user account when logged in as admin' do
      post login_path, params: { username: admin_user.username, password: admin_user.password }
      
      expect(response).to redirect_to(root_path)
      expect(User.count).to eq(3)

      delete user_path(team_member)
      expect(response).to redirect_to(root_path)
      
      follow_redirect!
      expect(response.body).to include('User was deleted')
      expect(User.count).to eq(2)
    end

    it 'Does not delete admin account when logged in as user' do
      post login_path, params: { username: team_member.username, password: team_member.password }

      expect(response).to redirect_to(root_path)
      expect(User.count).to eq(3)

      delete user_path(admin_user)
      expect(response).to redirect_to(root_path)
      
      follow_redirect!
      expect(response.body).to include('You are not authorised to perform that action')
      expect(User.count).to eq(3)

      delete user_path(team_member_2)
      expect(response).to redirect_to(root_path)

      follow_redirect!
      expect(response.body).to include('You are not authorised to perform that action')
      expect(User.count).to eq(3)
    end    
  end
end
require "rails_helper"

RSpec.describe Note do
  let!(:team_member)      { create(:user) }
  let!(:admin)            { create(:admin) }
  let!(:team_member_note) { create(:note, user: team_member) }

  describe 'New note' do
    it 'Will be owned by a user' do
      expect(team_member_note.owned_by?(team_member)).to eq(true)
      expect(team_member_note.owned_by?(admin)).to eq(false)
    end
  end
end
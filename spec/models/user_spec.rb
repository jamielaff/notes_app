require "rails_helper"

RSpec.feature User, type: :model do
  describe 'new user' do
    it 'will default to non admin' do
      user = User.create(username: 'user', password: 'password', email: 'email@email.com')
      expect(User.first.is_admin?).to eq(false)
    end
  end
end
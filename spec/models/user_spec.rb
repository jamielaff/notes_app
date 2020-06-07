require "rails_helper"

RSpec.feature User, type: :model do
  describe 'New user' do
    it 'Will default to non admin' do
      user = User.create(username: 'user', password: 'password', email: 'email@email.com')
      expect(user.is_admin?).to eq(false)
    end
  end
end
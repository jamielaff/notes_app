require "rails_helper"

RSpec.describe User do
  describe 'New user' do
    it 'Will default to non admin' do
      user = User.create(username: 'user', password: 'password', email: 'email@email.com')
      expect(user.is_admin?).to eq(false)
    end
  end
end
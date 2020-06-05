FactoryBot.define do
  factory :user, class: 'user' do
    username  { 'team_member' }
    email     { 'team@email.com' }
    password  { 'password' }
    is_admin  { false }
  end

  factory :another_user, class: 'user' do
    username  { 'team_member_2' }
    email     { 'team2@email.com' }
    password  { 'password' }
    is_admin  { false }
  end
  
  factory :admin, class: 'user' do
    username  { 'admin' }
    email     { 'admin@email.com' }
    password  { 'password' }
    is_admin  { true }
  end

  factory :another_admin, class: 'user' do
    username  { 'admin2' }
    email     { 'admin2@email.com' }
    password  { 'password' }
    is_admin  { true }
  end
end
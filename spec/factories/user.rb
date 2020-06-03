FactoryBot.define do
  factory :user do
    username  { 'team_member' }
    email     { 'team@email.com' }
    password  { 'password' }
    is_admin  { false }
  end

  factory :another_user, parent: :user do
    username  { 'team_member_2' }
    email     { 'team2@email.com' }
  end
  
  factory :admin, parent: :user do
    username  { 'admin' }
    email     { 'admin@email.com' }
    is_admin  { true }
  end

  factory :another_admin, parent: :admin do
    username  { 'admin2' }
    email     { 'admin2@email.com' }
  end
end
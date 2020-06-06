FactoryBot.define do
  factory :note, class: 'note' do
    user
    title       { 'Title of team member note' }
    description { 'Description of team member note' }
    is_active   { true }
  end

  factory :admin_note, class: 'note' do
    user
    title       { 'Title of admin note' }
    description { 'Description of admin note' }
    is_active   { true }
  end

  factory :pending_note, class: 'note' do
    user
    title       { 'Title of pending note' }
    description { 'Description of pending note' }
  end
end
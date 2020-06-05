FactoryBot.define do
  factory :note, class: 'note' do
    user
    title       { 'Title of team member note' }
    description { 'Description of team member note' }
  end

  factory :admin_note, class: 'note' do
    user
    title       { 'Title of team member note' }
    description { 'Description of team member note' }
  end
end
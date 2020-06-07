# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Add some users - 6 to show pagination on users_path page
User.create(username: 'john',     password: 'railsIsAwesome', email: 'john@techtest.com', is_admin: true)
User.create(username: 'admin',    password: 'xyz123',         email: 'admin@email.com',   is_admin: true)
User.create(username: 'member1',  password: 'member1',        email: 'member1@gmail.com', is_admin: false)
User.create(username: 'member2',  password: 'member2',        email: 'member2@gmail.com', is_admin: false)
User.create(username: 'member3',  password: 'member3',        email: 'member3@gmail.com', is_admin: false)
User.create(username: 'member4',  password: 'member4',        email: 'member4@gmail.com', is_admin: false)

# Some active notes - 6 to show pagination on root_path page
Note.create(title: 'Note by John',    description: 'A note which was created by admin user John.',          user: User.find(1), is_active: true)
Note.create(title: 'Note by admin',   description: 'A note which was created by admin user admin.',         user: User.find(2), is_active: true)
Note.create(title: 'Note by member1', description: 'A note which was created by team_member user member1.', user: User.find(3), is_active: true)
Note.create(title: 'Note by member2', description: 'A note which was created by team_member user member2.', user: User.find(4), is_active: true)
Note.create(title: 'Note by member3', description: 'A note which was created by team_member user member3.', user: User.find(5), is_active: true)
Note.create(title: 'Note by member4', description: 'A note which was created by team_member user member4.', user: User.find(6), is_active: true)

# Some pending notes - 6 to show pagination on pending_notes_path page
Note.create(title: 'Pending note by John',    description: 'A note which was created by admin user John, but is in a pending state. Needs approval by an admin.',           user: User.find(1), is_active: false)
Note.create(title: 'Pending note by admin',   description: 'A note which was created by admin user admin, but is in a pending state. Needs approval by an admin.',          user: User.find(2), is_active: false)
Note.create(title: 'Pending note by member1', description: 'A note which was created by team_member user member1, but is in a pending state. Needs approval by an admin.',  user: User.find(3), is_active: false)
Note.create(title: 'Pending note by member2', description: 'A note which was created by team_member user member2, but is in a pending state. Needs approval by an admin.',  user: User.find(4), is_active: false)
Note.create(title: 'Pending note by member3', description: 'A note which was created by team_member user member3, but is in a pending state. Needs approval by an admin.',  user: User.find(5), is_active: false)
Note.create(title: 'Pending note by member4', description: 'A note which was created by team_member user member4, but is in a pending state. Needs approval by an admin.',  user: User.find(6), is_active: false)
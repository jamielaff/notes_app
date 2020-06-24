module Types
  class QueryType < BaseObject
    # /users
    field :users, [UserType], null: false
    # /user/id
    field :user, UserType, null: false do
      argument :id, ID, required: true
    end
    # /notes
    field :notes, [NoteType], null: true
    # /currentUser
    field :current_user, UserType, null: false

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    end

    def notes
      Note.all
    end
  end
end

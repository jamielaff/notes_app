module Types
  class QueryType < Types::BaseObject

    field :users, [Types::UserType], null: false, description: "All the users"
    field :user, Types::UserType, null: false, description: "User by ID" do
      argument :id, ID, required: true
    end
    field :notes, [Types::NoteType], null: true, description: "All the notes"
    field :currentUser, Types::UserType, null: false

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

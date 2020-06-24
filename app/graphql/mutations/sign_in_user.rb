module Mutations
  class SignInUser < BaseMutation
    null true

    argument :username, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(username: nil, password: nil)
      # basic validation
      return unless username
      return unless password

      @user = User.find_by username: username
      puts password

      # ensures we have the correct user
      return unless @user
      if @user.authenticate(password)
        # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("user-id:#{ @user.id }")

        context[:session][:token] = token

        user = @user,
        token = token
      else
        puts 'No entero bro'
      end
    end
  end
end
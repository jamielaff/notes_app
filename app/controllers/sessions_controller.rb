class SessionsController < ApplicationController
  skip_before_action :authorised
  
  def new
    @user = User.new
  end

  def create
    query_string = "
    mutation {
      signinUser(
        username: $username,
        password: $password,
      ) {
        user {
          id
        }
        token
      }
    }"
    
    NotesAppSchema.execute(query_string, variables: variables)

    @user = User.find_by(username: params[:username].downcase)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "You have logged in"
      redirect_to root_path
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end

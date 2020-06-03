class UsersController < ApplicationController
  skip_before_action :authorised, only: [:index, :new, :create, :show]

  before_action :authorised_for_user_actions?, except: [:index, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Created new user, #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
     end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "#{@user.username}'s account was updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User was deleted"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :is_admin)
  end
end
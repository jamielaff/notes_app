class UsersController < ApplicationController
  skip_before_action :authorised, only: [:index, :new, :create, :show]

  before_action :authorised_for_user_create, except: [:index, :show, :edit, :update, :destroy]
  before_action :authorised_for_user_update, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if !logged_in?
        flash[:success] = "Welcome #{@user.username}"
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash[:success] = "Created new user, #{@user.username}"
        redirect_to user_path(@user)
      end
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
    if current_user == @user
      reset_session
    end
    @user.destroy
    flash[:success] = "User was deleted"
    redirect_to root_path
  end

  private

  def authorised_for_user_create
    unless logged_in_as_admin? || !logged_in?
      flash[:danger] = "You are not authorised to perform that action"
      redirect_to root_path
    end
  end

  def authorised_for_user_update
    unless logged_in_as_admin? || current_user == User.find(params[:id])
      flash[:danger] = "You are not authorised to perform that action"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :is_admin)
  end
end
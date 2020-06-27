module Api
  module V1
    class UsersController < ApplicationController
      #skip_before_action :authorised, only: [:index, :new, :create, :show]

      before_action :authorised_for_user_create, except: [:index, :show, :edit, :update, :destroy]
      before_action :authorised_for_user_update, except: [:index, :new, :create, :show]

      def index
        @users = User.paginate(page: params[:page], per_page: 5)
        render json: @users
      end

      def new
        @user = User.new
        render json: @user
      end

      # This is used for signup & admin create user. It would be worth moving signup logic out of this CRUD
      def create
        @user = User.new(user_params)
        if @user.save
          payload = { user_id: user.id }
          session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
          tokens = session.login
          response.set_cookie(JWTSessions.access_cookie, 
                              value: tokens[:access],
                              httponly: true,
                              secure: Rails.env.production?)
          render json: { csrf: tokens[:csrf] }
          # if logged_out?
          #   session[:user_id] = @user.id
          #   respond_to do |format|
          #     format.js {
          #       flash[:success] = "Welcome #{@user.username}"
          #       render js: "window.location = '#{root_path}'"
          #     }
          #   end
          # else
          #   respond_to do |format|
          #     format.js {
          #       flash[:success] = "Created new user, #{@user.username}"
          #       render js: "window.location = '#{user_path(@user)}'"
          #     }
          #   end
          # end
        else
          render json: { error: @user.errors.full_messages.join(' ')}, status: :unprocessable_entity
          # respond_to do |format|
          #   format.js
          # end
        end
      end

      def edit
        render json: @user = User.find(params[:id])
      end

      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          render json: @user, status: :created, location: @user
          # respond_to do |format|
          #   format.js {
          #     flash[:success] = "#{@user.username}'s account was updated successfully"
          #     render js: "window.location = '#{user_path(@user)}'"
          #   }
          # end
        else
          render json: @user.errors, status: :unprocessable_entity
          # respond_to do |format|
          #   format.js
          # end
        end
      end

      def show
        render json: @user = User.find(params[:id])
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
        unless logged_in_as_admin? || logged_out?
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
  end
end

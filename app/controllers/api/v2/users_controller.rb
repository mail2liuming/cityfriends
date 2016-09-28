module Api
  module V2

    class UsersController < ApplicationController
      respond_to :json
      before_action :check_auth?, only:[:show,:update,:friends,:add_friend,:delete_friend]
      
      def show
        
      end
  
      swagger_controller :users, 'users'

      swagger_api :create do
          summary 'Returns all posts'
      end
  
  
      def create 
        @user = User.new(user_params)
        if @user.save
          #render json: @user.to_json(:only => [ :id, :name,:email ],:methods => :token)
          @user
        else
          #render json: {:error =>@user.errors}
          @error = {status: 400, message: @user.errors.to_s}
          render partial: 'api/v2/shared/api_error'
        end
      end
      
      def login
        if(params.has_key?(:email) && params.has_key?(:password))
          @user = User.find_by(email: params[:email].downcase)
          if @user && @user.authenticate(params[:password])
            @user.login
            render json: @user.to_json(:only => [ :id, :name,:email ],:methods => :token)
          else
            if @user
                @error = {status: 400, message: 'Bad Request'}
            else
                @error = {status: 404, message: 'No User'}
            end
            render partial: 'api/v2/shared/api_error',status: @error[:status]
          end
        end
      end
      
      def update
      end
      
      def friends
        #TODO it is not best practise?
        @friends = @user.active_relationship.includes(:positive_user) + @user.positive_relationship.includes(:user)
        logger.info @friends
        @friends
        
      end
      
      def add_friend
        @friend = User.find_by(id: params[:friend_id])
        if @friend
          @user.add_friend(@friend)
          render partial: 'api/v2/shared/api_success'
        else
          @error = {status: 400, message: 'No this user'}
          render partial: 'api/v2/shared/api_error', status: @error[:status]
        end
      end
      
      def delete_friend
        @friend = User.find_by(id: params[:friend_id])
        if @friend && @user.delete_friend(@friend)
          render partial: 'api/v2/shared/api_success'
        else
          @error = {status: 400, message: 'No this user'}
          render partial: 'api/v2/shared/api_error', status: @error[:status]
        end
      end
      
      private 
        def user_params
          params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
        end

    end
  end
end

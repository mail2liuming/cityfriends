module Api
  module V2

    class UsersController < ApplicationController
      before_action :authenticated?, only:[:show,:update,:freinds]
      respond_to :json
      
      def show
        render json: @user
      end
  
      def create 
        @user = User.new(user_params)
        if @user.save
          render json: @user.to_json(:only => [ :id, :name,:email ],:methods => :token)
        else
          render json: {:error =>@user.errors}
        end
      end
      
      def login
        @user = User.find_by(params[:email].downcase)
        if @user && @user.authenticate(params[:password])
          render json: @user.to_json(:only => [ :id, :name,:email ],:methods => :token)
        else
          render json: {:error =>@user.errors}
        end
      end
      
      def update
      end
      
      def freinds
        render json:  @user.freinds
      end
      
      private 
        def user_params
          params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
        end

    end
  end
end

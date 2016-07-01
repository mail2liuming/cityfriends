module Api
  module V2

    class UsersController < ApplicationController
      before_action :check_auth?, only:[:show,:update,:freinds,:add_freind,:delete_freind]
      respond_to :json
      
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
            @error = {status: 400, message: 'Bad Request'}
            render partial: 'api/v2/shared/api_error'
          end
        end
      end
      
      def update
      end
      
      def freinds
        render json:  @user.freinds
      end
      
      def add_freind
        @freind = User.find_by(id: params[:freind_id])
        if @freind
          @user.add_freind(@freind)
          render json: {:success =>true}
        else
          render json: {:error =>"No this user"}
        end
      end
      
      def delete_freind
        @freind = User.find_by(id: params[:freind_id])
        if @freind && @user.delete_freind(@freind)
          render json: {:success =>true}
        else
          render json: {:error =>"No this user"}
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

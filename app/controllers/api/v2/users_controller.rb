module Api
  module V2

    class UsersController < ApplicationController
      before_action :check_auth?, only:[:show,:update,:freinds,:add_freind,:delete_freind]
      respond_to :json
      
      def show
        render json: @user.to_json(:only => [ :id, :name,:email ])
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
        @user = User.find_by(email: params[:email].downcase)
        if @user && @user.authenticate(params[:password])
          @user.login
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

module Api
  module V2
    class RelationshipsController < ApplicationController
        respond_to :json
        
        before_action :check_auth?, only:[:create,:destroy]
        
        def create
            @freind = User.find_by(id: params[:freind_id])
            if @freind
              @user.add_freind(@freind)
              render json: {:success =>true}
            else
              render json: {:error =>"No this user"}
            end
        end
        
        def destroy
            @freind = User.find_by(id: params[:freind_id])
            if @freind && @user.delete_freind(@freind)
              render json: {:success =>true}
            else
              render json: {:error =>"No this user"}
            end
        end
    end 
  end 
end

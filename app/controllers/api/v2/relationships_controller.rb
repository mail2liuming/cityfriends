module Api
  module V2
    class RelationshipsController < ApplicationController
        before_action :authenticated?, only:[:create,:destroy]
        respond_to :json
        
        def create
            @freind = User.find_by(id: params[:freind_id])
            if @freind
              @user.add_freind(@freind)
              render json: {:success =>true}
            else
              render json: {:error =>@freind.errors}
            end
        end
        
        def destroy
            @freind = User.find_by(id: params[:freind_id])
            if @freind
              @user.delete_freind(@freind)
              render json: {:success =>true}
            else
              render json: {:error =>@freind.errors}
            end
        end
    end 
  end 
end
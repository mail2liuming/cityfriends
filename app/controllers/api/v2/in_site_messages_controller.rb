module Api
  module V2
    class InSiteMessagesController < ApplicationController
        before_action :authenticated?, only:[:create,:update,:destroy]
        respond_to :json
        
        def create
            @new_msg = @user.sending_messages.build(receiver_id: params[:freind_id],msg_type:params[:msg_type])
            if @new_msg
                render json: {:success =>true}
            else
              render json: {:error =>@new_msg.errors}
            end
        end 
        
        def update
            @msg = InSiteMessage.find_by(id: params[:msg_id])
            if @msg
                @msg.update_attribute(msg_type: params[:msg_type])
                render json: {:success =>true}
            else
                render json: {:error =>@msg.errors}
            end
        end 
        
        def destroy
            @msg = InSiteMessage.find_by(id: params[:msg_id])
            if @msg
                @msg.destroy
                render json: {:success =>true}
            else
                render json: {:error =>@msg.errors}
            end
        end
    end
  end
end

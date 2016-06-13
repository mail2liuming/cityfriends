module Api
  module V2
    class InSiteMessagesController < ApplicationController
        before_action :check_auth?, only:[:create,:update,:destroy]
        respond_to :json
        
        def create
            @new_msg = @user.sending_messages.build(msg_params)
            if @new_msg.save
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
        
        private 
        
            def msg_params
                params.require(:msg).permit(:freind_id, :msg_type, :msg_content)
            end
    end
  end
end

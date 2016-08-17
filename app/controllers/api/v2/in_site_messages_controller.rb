module Api
  module V2
    class InSiteMessagesController < ApplicationController
        respond_to :json
        
        before_action :check_auth?, only:[:create,:update,:destroy]
        
        
        def index
                per_page = 25
                cur_page = 1
                if params.has_key?(:per_page)
                    per_page = params[:per_page]
                end 
                if params.has_key?(:page)
                    cur_page = params[:page]
                end 
                query = @user.messages.includes(:user).references(:user)
                @messages = query.paginate(page: cur_page,per_page: per_page)
        end
        
        def create
            @new_msg = @user.sending_messages.build(msg_params)
            if @new_msg.save
                if @new_msg.msg_type == InSiteMessage::TYPE_ACCEPT_FRIEND
                    @new_msg.receiver.add_freind(@new_msg.sender)
                end
                render_success
            else
                render_error(400,@new_msg.errors)
            end
        end 
        
        def update
            @msg = InSiteMessage.find_by(id: params[:msg_id])
            if @msg
                @msg.update_attribute(status: params[:status])
                render json: {:success =>true}
            else
                render json: {:error =>@msg.errors}
            end
        end 
        
        def destroy
            @msg = InSiteMessage.find_by(id: params[:msg_id])
            if @msg && @msg.destroy
                render_success
            else
                render_error(400,'bad_request')
            end
        end
        
        def unreads
            msgs = params[:msgs]
            msgs.each do |msg| 
                @msg = InSiteMessage.find_by(msg[:msg_id])
                if @msg
                    @msg.update_attribute(status: msg[:status])
                else
                    render_error(400,"bad request")
                end
            end
            render_success
        end
        
        private 
        
            def msg_params
                params.require(:msg).permit(:receiver_id, :msg_type, :msg_content)
            end
    end
  end
end

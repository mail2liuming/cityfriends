module Api
  module V2
    class InSiteMessagesController < ApplicationController
        respond_to :json
        
        before_action :check_auth?, only:[:create,:update,:destroy,:index]
        
        
        def index
                per_page = 25
                cur_page = 1
                if params.has_key?(:per_page)
                    per_page = params[:per_page]
                end 
                if params.has_key?(:page)
                    cur_page = params[:page]
                end 
                
                query = InSiteMessage.includes(:sender,:receiver).where("sender_id=:user_id OR receiver_id=:user_id",user_id:@user.id)
                @messages = query.paginate(page: cur_page,per_page: per_page)
        end
        
        def create
            @new_msg = @user.sending_messages.build(msg_params)
            logger.info @new_msg
            if @new_msg.save
                if @new_msg.msg_type == InSiteMessage::TYPE_ACCEPT_FRIEND
                    @new_msg.receiver.add_friend(@new_msg.sender)
                    @request_msg = @user.receiving_messages.where("msg_type=1 and sender_id=:receiver_id",receiver_id: @new_msg.receiver_id).first
                    if @request_msg
                        @request_msg.update_attribute(:status, InSiteMessage::STATUS_READ)
                    end
                end
                render partial: 'api/v2/shared/api_success'
            else
                @error = {status: 400, message: @new_msg.errors}
                render partial: 'api/v2/shared/api_error', status: @error[:status]
            end
        end 
        
        def update
            @msg = InSiteMessage.find_by(id: params[:msg_id])
            if @msg
                @msg.update_attribute(status: params[:status])
                render partial: 'api/v2/shared/api_success'
            else
                @error = {status: 400, message: @msg.errors}
                render partial: 'api/v2/shared/api_error', status: @error[:status]
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
                params.require(:in_site_message).permit(:receiver_id, :msg_type, :msg_content)
            end
    end
  end
end

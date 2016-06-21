module Api
    module V2
        class CalendarController < ApplicationController
            before_action :check_auth?, only:[:create,:destroy]
            respond_to :json
            
            def create
                @calendar = @user.calendars.build(feed_id: params[:feed_id],Calendar::TYPE_JOINER)
                if @calendar.save
                    render json: {:success =>true}
                else
                    render json: {:error =>@calendar.errors}
                end
            end
            
            def destroy
                @calendar = Calendar.find_by(id: params[:msg_id])
                if @calendar && @calendar.destroy
                    render json: {:success =>true}
                else
                    render json: {:error =>"error"}
                end
            end
            
        end
    end
end

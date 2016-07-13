module Api
    module V2
        class CalendarsController < ApplicationController
            respond_to :json
            
            before_action :check_auth?, only:[:index,:create,:destroy]

            def index
                per_page = 25
                cur_page = 1
                if params.has_key?(:per_page)
                    per_page = params[:per_page]
                end 
                if params.has_key?(:page)
                    cur_page = params[:page]
                end 
                query = @user.calendars.includes(:feed)
                
                #render json: query.paginate(page: cur_page,per_page: per_page)
                @calendars = query.paginate(page: cur_page,per_page: per_page)
            end
            
            def create
                if params.has_key?(:feed_id)
                    @calendar = @user.calendars.build(feed_id: params[:feed_id],calendar_type: Calendar::TYPE_JOINER)
                    if @calendar.save
                        render json: {:success =>true}
                    else
                        render json: {:error =>@calendar.errors}
                    end
                else
                    render json: {:error =>"bad request"}
                end
            end
            
            def destroy
                if params.has_key?(:calendar_id)
                    @calendar = Calendar.find_by(id: params[:calendar_id])
                    if @calendar && @calendar.destroy
                        render json: {:success =>true}
                    else
                        render json: {:error =>"error"}
                    end  
                else
                    render json: {:error =>"bad request"}
                end
            end
            
        end
    end
end

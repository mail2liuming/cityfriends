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
                query = @user.calendars.includes(feed: :user).references(:feed)
                
                #render json: query.paginate(page: cur_page,per_page: per_page)
                @calendars = query.paginate(page: cur_page,per_page: per_page)
            end
            
            def create
                @calendar = @user.calendars.build(calendar_params)
                if @calendar.save
                    render_success
                else
                    render_error(400,"bad request")
                end
            end
            
            def destroy
                if params.has_key?(:calendar_id)
                    @calendar = Calendar.find_by(id: params[:calendar_id])
                    if @calendar && @calendar.destroy
                        render_success
                    else
                        render_error(400,"bad request")
                    end  
                else
                    render_error(400,"bad request")
                end
            end
            
            private 
            
                def calendar_params
                    params.require(:calendar).permit(:calendar_type, :feed_id, :exact_time)
                end
            
        end
    end
end

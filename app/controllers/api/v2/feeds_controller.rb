module Api
    module V2
        class FeedsController < ApplicationController
            respond_to :json
            
            before_action :check_auth?, only:[:show,:update,:create,:destroy]
            def show
                feed = Feed.find_by(id: params[:id])
                if feed 
                    render json: feed.to_json(:only => [:id, :feed_type,:flight_no,:start_place,:start_time,:end_place,:end_time,:available,:user_id ])
                else
                    render json: {:error => 'Not found'}
                end
            end
            
            def create
                if @user
                    new_feed = @user.feeds.build(feed_params)
                    if new_feed.save
                        @user.calendars.create!(feed_id: new_feed.id,calendar_type: Calendar::TYPE_OWNER)
                        render partial: 'api/v2/shared/api_success'
                    else
                        @error = {status: 501, message: new_feed.errors}
                        render partial: 'api/v2/shared/api_error', status: @error[:status]
                    end
                else
                    @error = {status: 501, message: 'No this user'}
                    render partial: 'api/v2/shared/api_error', status: @error[:status]
                end
            end
            
            def destroy
                
                feed = Feed.find_by(id: params[:id])
                logger.info feed.inspect
                if feed
                    if(feed.user.same?(@user))
                        feed.destroy
                        render json: {:success => true}
                    else
                          render json: {:error =>'Do not delete feeds of others'}
                    end
                else
                    render json: {:error =>@feed.errors}
                end
            end
            
            
            def update
                if @user
                    feed = Feed.find_by(id: params[:id])
                    if feed
                        feed.update_attribute(feed_params)
                        render json: {:success => true}
                    else
                        render json: {:error =>@feed.errors}
                    end
                else
                    render json: {:error => 'No this user'}
                end
            end
            
            def entries
                per_page = 25
                cur_page = 1
                if params.has_key?(:per_page)
                    per_page = params[:per_page]
                end 
                if params.has_key?(:page)
                    cur_page = params[:page]
                end 
                query = nil
                if authenticated?
                    #include？
                    #query = Feed.joins(:user).select(:id,:feed_type,:start_time,:start_place,:end_place,:end_time,:available,:user_id,'users.name as user_name')
                    query = Feed.includes(:user).references(:user)
                else
                    query = Feed.select(:id,:feed_type,:start_time,:start_place,:end_place,:end_time,:available)
                end
                
                #render json: query.paginate(page: cur_page,per_page: per_page)
                @feeds = query.paginate(page: cur_page,per_page: per_page)
            end
            
            private 
            
                def feed_params
                    params.require(:feed).permit(:feed_type, :email, :flight_no,
                                   :available,:start_place,:start_time,:end_place,:end_time)
                end
        end
    end
end
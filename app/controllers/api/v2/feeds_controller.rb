module Api
    module V2
        class FeedsController < ApplicationController
            before_action :authenticated?, only:[:show,:update,:create,:destroy]
            respond_to :json

            def show
                feed = Feed.find_by(params[:id])
                if feed 
                    render json: feed
                else
                    render json: {:error => 'Not found'}
                end
            end
            
            def create
                cur_user = current_user
                if cur_user
                    new_feed = cur_user.feeds.build(feed_params)
                    if new_feed.save
                        #render json: {:success => true}
                        render json: new_feed
                    else
                        render json: {:error =>new_feed.errors}
                    end
                else
                    render json: {:error => 'No this user'}
                end
            end
            
            def destroy
                cur_user = current_user
                if cur_user
                    feed = Feed.find_by(params[:id])
                    if feed
                        if(feed.user.same?(cur_user))
                            feed.destroy
                            render json: {:success => true}
                        else
                           render json: {:error =>'Do not delete feeds of others'}
                        end
                    else
                        render json: {:error =>@feed.errors}
                    end
                else
                    render json: {:error => 'No this user'}
                end
            end
            
            def update
                cur_user = current_user
                if cur_user
                    feed = Feed.find_by(params[:id])
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
                    query = Feed.include(:user).select(:id,:feed_type,:start_time,:start_place,:end_place,:end_time,:available,'user.name')
                else
                    query = Feed.select(:id,:feed_type,:start_time,:start_place,:end_place,:end_time,:available)
                end
                query.paginate(page: cur_page,per_age: per_age)
            end
            
            private 
            
                def feed_params
                    params.require(:feed).permit(:feed_type, :email, :flight_no,
                                   :available,:start_place,:start_time,:end_place,:end_time)
                end
        end
    end
end
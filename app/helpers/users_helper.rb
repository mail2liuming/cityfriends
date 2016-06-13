module UsersHelper
    def check_auth?
        @user = User.find_by(id: params[:user_id])
        
        if !(@user && @user.authenticated?(params[:token]))
            render json: {:error => 'Please Login'}
        end 
    end
    
    def authenticated?
        @user = User.find_by(id: params[:user_id])
        @user && @user.authenticated?(params[:token])
    end
    
    def current_user
        if authenticated?
           @user
        end
    end
end

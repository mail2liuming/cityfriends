module UsersHelper
    def authenticated?
        logger.info params[:user_id]
        logger.info params[:token]
        
        logger.info 'authenticated?'
        
        @user = User.find_by(id: params[:user_id])
        @user && @user.authenticate(params[:token])
        
        logger.info @user.inspect
    end
    
    def current_user
        if authenticated?
           @user
        end
    end
end

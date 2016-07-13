module UsersHelper
    USER_TOKEN = /\ABearer\s+(\d+)\s+([a-zA-Z0-9_.-]+)\s*\z/i
                 
    def check_auth?
        
        @user = User.find_by(id: get_user_id)
        
        if !(@user && @user.authenticated?(get_token))
            if @user
                @error = {status: 400, message: @user.errors.inspect}
            else
                @error = {status: 501, message: 'no user'}
            end
            render partial: 'api/v2/shared/api_error', status: @error[:status]
        end 
    end
    
    def authenticated?
        @user = User.find_by(id: get_user_id)
        if @user
            @user.authenticated?(get_token)
        else
            false
        end
    end
    
    def current_user
        if authenticated?
           @user
        end
    end
    
    private 
        def get_user_id
            user_id = -1
            if user_token = request.headers[:Authorization]
                if user_token =~USER_TOKEN
                    user_id = $1
                end
            end
            user_id
        end  
        
        def get_token
            token = nil
            if user_token = request.headers[:Authorization]
                if user_token =~USER_TOKEN
                    token = $2
                end
            end
            token
        end 
end

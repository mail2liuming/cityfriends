module ApplicationHelper
    def render_success
        render partial: 'api/v2/shared/api_success'
    end
    
    def render_error(res_status,res_message)
        @error = {status: res_status, message: res_message}
        render partial: 'api/v2/shared/api_error', status: @error[:status]
    end
end

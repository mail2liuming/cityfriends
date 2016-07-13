module Api
    module V2
        class ApisController < ApplicationController
            skip_before_action :verify_authenticity_token 
        end
    end
end
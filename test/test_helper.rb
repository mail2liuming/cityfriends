ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'logger'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  logger = Rails.logger
  
  def login_as(user)
    user.login
    Rails.logger.info user.id
    Rails.logger.info user.token
    auth = "Bearer #{user.id} #{user.token}"
    Rails.logger.info auth
    @request.headers[:authorization] = auth
  end
  
  def api_content_type
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
  end

  # Add more helper methods to be used by all tests here...
end

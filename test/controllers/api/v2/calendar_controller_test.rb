require 'test_helper'

class Api::V2::CalendarControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  setup do
    # @user = users(:exam)
    @user = User.first
    @controller = CalendarsController.new
    Rails.logger.info @user.id
  end
  
  test "get list" do
    login_as(@user)
    api_content_type
    get :index, format: :json
    assert_response :success
    # assert true
  end
end

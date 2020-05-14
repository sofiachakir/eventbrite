require 'test_helper'

class EventPictureControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_picture_create_url
    assert_response :success
  end

end

require 'test_helper'

class SegmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get segments_create_url
    assert_response :success
  end

end

require 'test_helper'

class DraftsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get drafts_new_url
    assert_response :success
  end

end

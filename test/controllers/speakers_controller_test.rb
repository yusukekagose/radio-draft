require 'test_helper'

class SpeakersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get speakers_index_url
    assert_response :success
  end

  test "should get update" do
    get speakers_update_url
    assert_response :success
  end

  test "should get create" do
    get speakers_create_url
    assert_response :success
  end

end

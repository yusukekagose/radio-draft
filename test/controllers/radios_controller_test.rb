require 'test_helper'

class RadiosControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get radios_show_url
    assert_response :success
  end

  test "should get index" do
    get radios_index_url
    assert_response :success
  end

  test "should get new" do
    get radios_new_url
    assert_response :success
  end

  test "should get create" do
    get radios_create_url
    assert_response :success
  end

  test "should get edit" do
    get radios_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get radios_destroy_url
    assert_response :success
  end

end

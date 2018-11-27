require 'test_helper'

class CocorocosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cocorocos_new_url
    assert_response :success
  end

  test "should get create" do
    get cocorocos_create_url
    assert_response :success
  end

  test "should get show" do
    get cocorocos_show_url
    assert_response :success
  end

end

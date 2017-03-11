require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase


  test "should show static_page" do
    get :front
    assert_response :success
  end



end

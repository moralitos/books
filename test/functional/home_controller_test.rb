require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get readme" do
    get :readme
    assert_response :success
  end

end

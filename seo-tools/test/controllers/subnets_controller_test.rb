require 'test_helper'

class SubnetsControllerTest < ActionController::TestCase
  setup do
    @subnet = subnets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subnets)
  end

  test "should show subnet" do
    get :show, id: @subnet
    assert_response :success
  end

end

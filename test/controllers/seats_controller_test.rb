require 'test_helper'

class SeatsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    seats = @controller.instance_variable_get(:@seats)
    assert_not_nil seats
  end

  test "should update seat" do
    seat = seats(:one)
    patch :update, params: { id: seat.id }
    assert_response :success
    # Add assertions to test the update logic and response as needed
  end

  test "should update multiple seats" do
    patch :update_multiple
    assert_response :success
    # Add assertions to test the update multiple logic and response as needed
  end
end

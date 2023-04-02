require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference("Restaurant.count") do
      post restaurants_url, params: { restaurant: { location: @restaurant.location, name: @restaurant.name, willSplit: @restaurant.willSplit, wontSplit: @restaurant.wontSplit } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { location: @restaurant.location, name: @restaurant.name, willSplit: @restaurant.willSplit, wontSplit: @restaurant.wontSplit } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy restaurant" do
    assert_difference("Restaurant.count", -1) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to restaurants_url
  end

  test "should increment willSplit by 1" do
    restaurant = restaurants(:one)
    initial_will_split_count = restaurant.willSplit

    patch increment_will_split_restaurant_path(restaurant, restaurant_id: restaurant.id)

    restaurant.reload
    assert_equal initial_will_split_count + 1, restaurant.willSplit
  end

  test "should increment wontSplit by 1" do
    restaurant = restaurants(:one)
    initial_wont_split_count = restaurant.wontSplit

    patch increment_wont_split_restaurant_path(restaurant, restaurant_id: restaurant.id)

    restaurant.reload
    assert_equal initial_wont_split_count + 1, restaurant.wontSplit
  end

end

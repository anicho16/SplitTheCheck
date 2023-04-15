require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:one)
    visit login_url
    fill_in "Email", with: "tester3@test.com"
    fill_in "Password", with: "testpass"
    click_on "Log in"
  end

  test "visiting the index" do
    visit restaurants_url
    assert_selector "h1", text: "Split the Check"
  end

  test "should create restaurant" do
    visit restaurants_url
    click_on "Add New Restaurant"

    fill_in "Location", with: @restaurant.location
    fill_in "Name", with: @restaurant.name
    click_on "Create Restaurant"

    assert_text "Restaurant was successfully created"
    click_on "Home"
  end

  test "should update Restaurant" do
    visit restaurant_url(@restaurant)
    click_on "Edit Restaurant", match: :first

    fill_in "Location", with: @restaurant.location
    fill_in "Name", with: @restaurant.name
    click_on "Update Restaurant"

    assert_text "Restaurant was successfully updated"
    click_on "Home"
  end

end

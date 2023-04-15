require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
      visit new_user_path

      fill_in "user_username", with: "testuser"
      fill_in "user_email", with: "testuser@example.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"

      click_on "Create my account"

      assert_text "User was successfully created."
      assert_current_path root_path
  end

  test "should show error messages if user creation fails" do
    visit new_user_path

    fill_in "user_username", with: ""
    fill_in "user_email", with: ""
    fill_in "user_password", with: ""
    fill_in "user_password_confirmation", with: ""

    click_on "Create my account"

    assert_selector "div", class: "field_with_errors", count: 6
  end

=begin
test "should update User" do
  visit user_url(@user)
  click_on "Edit this user", match: :first

  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  fill_in "Username", with: @user.username
  click_on "Update User"

  assert_text "User was successfully updated"
  click_on "Back"
=end

  test "should destroy User" do
    @user.votes.destroy_all # Delete associated Vote records
    visit user_url(@user)
    click_on "Destroy this user", match: :first

    assert_text "User was successfully destroyed"
  end
end

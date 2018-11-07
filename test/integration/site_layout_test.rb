require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "default layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get help_path
    assert_select "title", full_title("Help")
    get about_path
    assert_select "title", full_title("About")
    get contact_path
    assert_select "title", full_title("Contact")
    get root_path
    assert_select "title", full_title
  end

  test "layout links as guest" do
    get root_path
    assert_template 'static_pages/home'
    get login_path
    assert_select "title", full_title("Log in")
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links as logged in user" do
    get login_path
    log_in_as @user
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    get users_path
    assert_select "title", full_title("All users")
    get user_path(@user)
    assert_select "title", full_title(@user.name)
    get edit_user_path(@user)
    assert_select "title", full_title("Edit user")
  end
end

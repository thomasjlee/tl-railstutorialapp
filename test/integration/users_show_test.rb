require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @admin            = users(:michael)
    @non_admin        = users(:archer)
    @unactivated_user = users(:cyril)
  end

  test "show of unactivated user redirects to home" do
    log_in_as(@admin)
    get user_path(@unactivated_user)
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/home'
  end
end

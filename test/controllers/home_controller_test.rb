require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  setup do
    @author = authors(:sean)
  end

  test "should get index" do
    get root_path
    assert_response :success
  end

  test "should show correct navigation links when logged in" do
    sign_in @author
    get root_path
    assert_select "a", { text: "Sign out"}, "Sign out link is not displayed."
    assert_select "a", { text: "Sign in", count: 0}, "Sign in link displayed."
    assert_select "a", { text: "Sign up", count: 0}, "Sign up link displayed."
    assert_select "a", "Books"
    assert_select "a", "Home"
    assert_select "a", @author.name, "Name is not displayed"
  end

end

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
  end

  test "should show correct navigation links" do
    sign_in authors(:one)
    get root_path
    assert_select "p" do |elements|
      puts elements.text.inspect
    end
    assert_select "a", { text: "Sign out"}, "Sign out link is not displayed."
    assert_select "a", { text: "Sign in", count: 0}, "Sign in link displayed."
    assert_select "a", { text: "Sign up", count: 0}, "Sign up link displayed."
  end



end

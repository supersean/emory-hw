require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @author = authors(:sean)
    sign_in @author
  end

  # index

  test "should get index" do
    get authors_url
    assert_response :success
  end

  # show

  test "should get show" do
    get authors_url @author.id
    assert_response :success
  end

  test "should not show edit links for other authors" do
    get authors_url
    assert_select "a", { text: "Edit", count: 1 }, "More than 1 edit link is present"
  end

  # edit 

  test "should get edit" do
    get edit_author_url @author.id
    assert_response :success
  end

  test "should not get edit for other authors" do
    get edit_author_url authors(:tom)
    assert_response :redirect
  end

  # update

  test "should edit author information" do
    id = @author.id
    patch author_url(@author), params: { author: { name: 'steven davis' }}
    assert_equal Author.find(id).name, 'steven davis'
  end

  test "should not edit other authors" do
    other_author = authors(:tom)
    patch author_url(other_author.id), params: { author: { name: 'steve' } }
    assert_equal(other_author.name, Author.find(other_author.id).name)
  end

end

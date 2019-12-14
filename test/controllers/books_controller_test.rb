require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = authors(:sean)
    sign_in @author
    @book = books(:seans_struggle)
  end

  test "should get index when logged in" do
    get books_url
    assert_response :success
  end

  test "should get index when not logged in" do
    sign_out :author
    get books_url
    assert_response :success
  end

  test "should only show CRUD links when logged in" do
    get books_url
    assert_select "a", "New Book"
    assert_select "a", "Edit"
    assert_select "a", "Destroy"
    sign_out :author
    get books_url
    assert_select "a", {text: "New Book", count: 0}, "Should not see new book link."
    assert_select "a", {text: "Edit", count: 0}, "Should not see edit link"
    assert_select "a", {text: "Destroy", count: 0}, "Should not see destroy link"
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should redirect when author not logged in (not index)" do
    sign_out :author
    get new_book_url
    assert_response :redirect
  end

  test "should create book" do
    assert_difference('Book.count') do
      post books_url, params: { book: { author_id: @book.author.id, title: @book.title } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { author: @book.author, title: @book.title } }
    assert_redirected_to book_url(@book)
  end

  test "authors should only be able to edit their own books" do
    bad_book = Book.create title: "Toms life", author: authors(:tom)
    patch book_url(bad_book), params: { book: { author: bad_book.author, title: "seans life" } }
    assert_response :redirect
    book = Book.find(bad_book.id)
    assert_equal bad_book.title, book.title, "Book should not be edited by different user."
  end

  test "only logged authors should be able to create books" do
    sign_out :author

    assert_no_changes('Book.count') do
      post books_url, params: { book: { author_id: @book.author.id, title: @book.title } }
    end
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end

  test "should only destroy owned books" do
    tom = authors :tom
    assert_no_difference('Book.count') do
      delete book_url(tom.books.first)
    end
  end
end

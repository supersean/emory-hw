require 'test_helper'

class BookTest < ActiveSupport::TestCase

  setup do
    @author = authors(:sean)
  end

  test "is valid with valid parameters" do
    book = Book.create(title: "The sea", author: @author)
    assert book.valid?
  end

  test "is invalid without an author" do
    book = Book.create title: "The sea"
    assert book.invalid?
  end

  test "is invalid without a title" do
    book = Book.create author: @author
    assert book.invalid?
  end

  test "is editable by its author" do
    book = books :seans_struggle
    assert book.editable_by?(book.author)
  end

  test "is not editable by another author" do
    book = books :toms_life
    refute book.editable_by?(@author)
  end
end
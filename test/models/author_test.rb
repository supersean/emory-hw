require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

  test "is valid with valid parameters" do
    author = Author.create name: "sean", email: "sean.davis1289@gmail.com", password: "password"
    assert author.valid?
  end

  test "is invalid without an email" do
    author = Author.create name: "sean", password: "password"
    assert author.invalid?
  end

  test "is invalid without a name" do
    author = Author.create email: "sean.davis1289@gmail.com", password: "password"
    assert author.invalid?
  end

  test "is invalid without a password" do
    author = Author.create name: "sean", email: "sean.davis1289@gmail.com"
    assert author.invalid?
  end

  test "can be edited by self" do
    author = authors(:sean)
    assert author.editable_by? author
  end

  test "can not be edited by another author" do
    sean = authors(:sean)
    tom = authors(:tom)
    refute sean.editable_by? tom
  end

end

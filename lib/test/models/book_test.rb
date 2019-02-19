require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "book should be valid" do
    book = Book.new(:isbn => "978-3-16-148410-0-21", :name => "testBook", :authors => "testAuthor1,testAuthor2", :description => "test Desc", :status => 0, :isDeleted => FALSE)
    assert book.save
  end

  test "validation checks for books" do
    # No isbn
    book = Book.new(:name => "testBook", :authors => "testAuthor1,testAuthor2", :description => "test Desc", :status => 0, :isDeleted => FALSE)
    assert_not book.valid?

    # No name
    book = Book.new(:isbn => "978-3-16-148410-0-21", :authors => "testAuthor1,testAuthor2", :description => "test Desc", :status => 0, :isDeleted => FALSE)
    assert_not book.valid?

    # No author
    book = Book.new(:isbn => "978-3-16-148410-0-21", :name => "testBook", :description => "test Desc", :status => 0, :isDeleted => FALSE)
    assert_not book.valid?

    # No status
    book = Book.new(:isbn => "978-3-16-148410-0-21", :name => "testBook", :authors => "testAuthor1,testAuthor2", :description => "test Desc", :isDeleted => FALSE)
    assert_not book.valid?

    book = Book.new(:isbn => "978-3-16-148410-0-21", :name => "testBook", :authors => "testAuthor1,testAuthor2", :status => 0, :isDeleted => FALSE)
    assert book.valid?

  end

  test "No duplicate ISBNs should be created" do
    bookA = Book.new(:isbn => "978-3-16-148410-0-21", :name => "testBookA", :authors => "testAuthor1A,testAuthor2A", :description => "test Desc A", :status => 0, :isDeleted => FALSE)
    bookA.save

    bookB = Book.new(:isbn => "978-3-16-148410-0-21", :name => "testBookB", :authors => "testAuthor1B,testAuthor2B", :description => "test Desc B", :status => 0, :isDeleted => FALSE)
    assert_not bookB.save
  end
end

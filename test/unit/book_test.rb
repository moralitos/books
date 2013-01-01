require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test "A book category should contain: book, magazine or audiobook" do
    book = Book.new(isbn:12345, author:'Edgar Allan Poe', publisher:'Garmin', title:'Short Stories', date_published:'1912-01-01', unit_cost:5.00, category:'book')
    book.save
    assert_equal([], book.errors.full_messages)
  end

  test "A book category should only contain: book, magazine or audiobook" do
    book = Book.new(isbn:12345, author:'Edgar Allan Poe', publisher:'Garmin', title:'Short Stories', date_published:'1912-01-01', unit_cost:5.00, category:'other')
    book.save
    assert_equal(["Category other is not a valid category."], book.errors.full_messages)
  end
end

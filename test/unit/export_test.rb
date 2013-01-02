require 'test_helper'

class ExportTest < ActiveSupport::TestCase

  setup do
    @stream = File.read("#{Rails.root}/test/fixtures/isbndb_sample.html")
    @export = Export.new(@stream)
  end

  test "A an export object created from the isbndb should have bookInfo css classes" do
    assert_equal(20, @export.book_infos.count )
  end

  test "An exported book should have a title" do
    assert_equal('84 Charing Cross Road', @export.isbn_books.first.title)
  end

  test "An exported book should have a publisher" do
    assert_equal('Futura', @export.isbn_books.first.publisher)
  end

  test "An exported book should have an author" do
    assert_equal('Helene Hanff', @export.isbn_books.first.author)
  end

  test "An exported book should have an ISBN" do
    assert_equal('0860074382', @export.isbn_books.first.isbn)
  end

  test "An export should be able to parse all entries from the web stream" do
    @export.isbn_books.each do |isbn_book|
      assert(isbn_book.title)
      assert(isbn_book.publisher)
      assert(isbn_book.author)
      assert(isbn_book.isbn)
    end
  end

end

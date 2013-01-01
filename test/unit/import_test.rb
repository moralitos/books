require 'test_helper'

class ImportTest < ActiveSupport::TestCase

  setup do
    @file_path = "#{Rails.root}/test/fixtures/import_file.csv"
  end

  test "A CSV file formatted correctly should pass validation" do
    import = Import.new(@file_path) 
    import.validate_input
    assert_equal([], import.errors)
  end

  test "A CSV file formatted incorrectly should not pass validation" do
    import = Import.new("#{Rails.root}/test/fixtures/import_file_bad_headings.csv") 
    import.validate_input
    assert_equal(["File does not have the correct headings. Please use the template provided via the export link."], import.errors)
  end

  test "A malformed CSV file should error out" do
    import = Import.new("#{Rails.root}/test/fixtures/workbook.xls")
    import.validate_input
    assert(import.errors.include?("CSV is not formed correctly. invalid byte sequence in UTF-8"), "Expected to error on headings but got: #{import.errors.inspect}")
  end

  test "An import should create new books if the books do not exist" do
    Book.delete_all #make sure there are no books
    import = Import.new(@file_path)
    import.import_books!
    assert(Book.all.size == 3, "Expected 3 books but got: #{Book.all.inspect}") # the fixture file has three books
  end

  test "An import should replace book attributes if the books already exist" do
    Book.delete_all #make sure there are no books
    import = Import.new(@file_path)
    import.import_books!
    book = Book.find_by_isbn('B00AILCF2C')
    assert_equal('magazine', book.category)
    assert_equal(3, Book.all.size)

    second_import = Import.new("#{Rails.root}/test/fixtures/import_with_existing_entry.csv")
    second_import.import_books!
    same_book = Book.find_by_isbn('B00AILCF2C')
    assert_equal(3, Book.all.size)
    assert_equal('audiobook', same_book.category)
  end


end

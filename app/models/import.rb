class Import
  attr_reader :errors

  def initialize(file_path)
    @file_path = file_path
    @errors = []
    @entries = []
  end

  def headings
    csv.headers if csv 
  end

  def validate_input
    validate_headings if csv
  end

  def validate_headings
    unless ["isbn", "title", "author", "publisher", "date_published", "unit_cost", "category"] == headings
      @errors << "File does not have the correct headings. Please use the template provided via the export link."
    end
  end

  def csv
    @csv ||= parse_csv
  end

  def parse_csv
    begin
      CSV.parse(File.read(@file_path), :headers => true)
    rescue Exception => e
      @errors << "CSV is not formed correctly. #{e.message}"
      nil
    end
  end

  def import_books!
    csv.each do |row|
      book = Book.find_or_create_by_isbn(row['isbn'])
      book.attributes = {title:row['title'], author:row['author'], publisher:row['publisher'], date_published:row['date_published'],
        unit_cost:row['unit_cost'], category:row['category']}
      book.save
      @entries << book
    end
  end

  def entries_imported
    @rows_imported ||= @rows.select {|row| row.errors.blank?}
  end

  def entries_with_errors
    @rows - rows_imported
  end
  
end

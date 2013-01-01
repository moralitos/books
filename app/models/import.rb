class Import
  attr_reader :errors, :entries

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
    csv.each do |entry|
      book = Book.find_or_create_by_isbn(entry['isbn'])
      book.attributes = {title:entry['title'], author:entry['author'], publisher:entry['publisher'], date_published:entry['date_published'],
        unit_cost:entry['unit_cost'], category:entry['category']}
      book.save
      @entries << book
    end
  end

  def entries_imported
    @entries_imported ||= @entries.select {|entry| entry.errors.blank?}
  end

  def entries_with_errors
    @entries - entries_imported
  end
  
end

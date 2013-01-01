# To seed the system, web scraping a public isbn database to get some sample books
# generating the publication date, category and price randomly
# run the class method self.random_export to get a csv stream
class Export

  def self.urls
    [
      "http://isbndb.com/d/subject/authors_american_20th_century/books.html",
      "http://isbndb.com/d/subject/women_authors_american_20th_century_biography/books.html?start_item=61",
      "http://isbndb.com/d/subject/authors_american_fiction/books.html",
      "http://isbndb.com/d/subject/authors_american_20th_century_fiction/books.html",
      "http://isbndb.com/d/subject/composition_music/books.html",
      "http://isbndb.com/d/subject/music_instruction_and_study/books.html"
    ] 
  end

  def self.random_export
    uri = URI(urls[rand(urls.size)])
    stream = Net::HTTP.get(uri)
    export = Export.new(stream)
    export.to_csv
  end

  def initialize(stream)
    @stream = stream
  end

  def doc
    @doc ||= Nokogiri::HTML.parse(@stream)
  end

  def book_infos
    doc.xpath('//div[@class="bookInfo"]')
  end

  def isbn_books
    book_infos.map {|book_info| IsbnBook.new(book_info)}
  end

  def to_csv
    CSV.generate do |csv|
      csv << ['isbn', 'title', 'author', 'publisher', 'date_published', 'unit_cost', 'category']
      isbn_books.each do |isbn_book|
        csv << [isbn_book.isbn, isbn_book.title, isbn_book.author, isbn_book.publisher, isbn_book.date_published, isbn_book.unit_cost, isbn_book.category]
      end
    end
  end

  class IsbnBook
    def initialize(book_info)
      @book_info = book_info
    end

    def title
      @book_info.xpath('a/h1').text rescue "Unknown"
    end

    def author
      @book_info.xpath('span[@class="small"]/a')[0].text rescue "Unknown"
    end

    def publisher
      @book_info.xpath('span[@class="small"]/a')[1].text rescue "Unknown"
    end

    def isbn
      @book_info.xpath('span[@class="small"]').text.to_s.match(/ISBN\: (\d+)/)[1] rescue "Unknown"
    end

    def category
      categories = %w(book audiobook magazine)
      categories[rand(categories.size)]
    end

    def date_published
      rand(Date.new(1930)..Date.new(2012)).to_s
    end

    def unit_cost
      "#{rand(5..50)}.#{rand(9)}#{rand(9)}"
    end
  end
end

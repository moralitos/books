class Book < ActiveRecord::Base
  self.per_page = 10

  def self.categories
    %w(book audiobook magazine)
  end

  attr_accessible :author, :category, :date_published, :isbn, :publisher, :title, :unit_cost

  validates_presence_of :author, :category, :date_published, :isbn, :publisher, :title, :unit_cost

  validates_uniqueness_of :isbn

  validates :category, :inclusion => {:in => Book.categories, :message => "%{value} is not a valid category."}

  # Category has a percentage of markup for calculating price
  # that will not be in the import file
  def price
    case category 
      when 'book'
        unit_cost * 1.10
      when 'audiobook'
        unit_cost * 1.20
      when 'magazine'
        unit_cost * 1.15
    end
  end

end

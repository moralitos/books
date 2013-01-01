class BooksController < ApplicationController

  autocomplete :book, :title, :full => true
  autocomplete :book, :author, :full => true
  autocomplete :book, :publisher, :full => true
  autocomplete :book, :category, :full => true

  def index
    @search = Book.search(params[:search])
    @books = @search.paginate(:page => params[:page])
  end

  def find
    @search = Book.search
  end

end

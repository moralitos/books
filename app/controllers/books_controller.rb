class BooksController < ApplicationController

  def index
    @search = Book.search(params[:search])
    @books = @search.paginate(:page => params[:page])
  end

  def find
    @search = Book.search
  end

end

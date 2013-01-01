class ImportsController < ApplicationController

  def new
  end

  def create
    begin
      @import = Import.new(params[:import][:filename].path)
      @import.import_books!
    rescue Exception => e
      flash[:error] = "Fatal error with import. Make sure you select a file. #{e.message}"
      redirect_to new_import_path
    end
  end

end

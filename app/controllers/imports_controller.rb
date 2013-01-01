class ImportsController < ApplicationController

  def new
  end

  def create
    
  end

  def export
    send_file "#{Rails.root}/config/import_template.csv"
  end
end

class ExportsController < ApplicationController

  def new
  end

  def create
    case params[:export_type]
    when 'full'
    when 'template'
      send_file "#{Rails.root}/config/import_template.csv"
    end
  end

end

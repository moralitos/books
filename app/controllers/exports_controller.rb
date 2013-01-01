class ExportsController < ApplicationController

  def new
  end

  def create
    case params[:export_type]
    when 'full'
      send_data Export.random_export, :filename => "random_export_#{rand(100)}.csv"
    when 'template'
      send_file "#{Rails.root}/config/import_template.csv"
    end
  end

end

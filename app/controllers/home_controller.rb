class HomeController < ApplicationController
  def readme
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    @html = markdown.render(File.read("#{Rails.root}/README.md"))
  end
end

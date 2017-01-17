require_relative 'asset_finder'
require_relative 'page_handler'

class Crawler

  def initialize(user_input)
    @parent_url = user_input
  end

  def crawl
    handler = PageHandler.new(parent_url)
    page = handler.document

    finder = AssetFinder.new(page)
    
    print_pretty(finder)
  end

  private 

  def print_pretty(finder)
    puts "\n\n ---- Links ----"
    puts finder.find_hyperlinks

    puts "\n\n ---- Scripts ----"
    puts finder.find_js_scripts

    puts "\n\n ---- CSS ----"
    puts finder.find_css_stylesheets

    puts "\n\n ---- Images ----"
    puts finder.find_images
  end

  def parent_url
    @parent_url
  end

end

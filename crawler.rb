require_relative 'asset_finder'
require_relative 'page_handler'
require_relative 'json_handler'
require_relative 'link_utils'

class Crawler

  def initialize(user_input, indexed_parenting)
    @parent_url = user_input
    @indexed_parenting = indexed_parenting
    @crawled = []
  end

  def crawl(url = parent_url)
    url = LinkUtils.preprocess_link(url)
    puts "Crawling through: #{url} ..."

    handler = PageHandler.new(url)
    page = handler.document
    crawled << url
    return if page.nil?

    finder = AssetFinder.new(page)
    assets = finder.find_all
    assets.delete(parent_url)
  
    valid_assets = LinkUtils.valid_static_assets(assets, parent_url)
    valid_assets.each do |valid_asset|
      direct_asset_parent, asset_child = LinkUtils.get_direct_parent_and_child(valid_asset)
      json.add(direct_asset_parent, valid_asset)
    end

    crawlable_child_urls = LinkUtils.generate_crawlable_urls(assets, parent_url, crawled) 

    crawlable_child_urls.each do |child_url|
      child_url = LinkUtils.preprocess_link(child_url)
      crawl(child_url) unless crawled.include?(child_url)
    end
  end

  def print(pretty)
    puts "\n\n ---- Final output ----"
    output = pretty ? json.print_pretty : json.print
    puts output
  end

  def save
  end

  private

  def crawled
    @crawled
  end

  def json
    @json ||= JSONHandler.new
  end

  def parent_url
    @parent_url
  end

end

require_relative 'asset_finder'
require_relative 'page_handler'
require_relative 'json_handler'
require_relative 'link_utils'

class Crawler

  def initialize(user_input)
    @parent_url = user_input
    @crawled = []
  end

  def crawl(url = parent_url)
    url = LinkUtils.preprocess_link(url)
    puts "Crawling through: #{url} ..."

    handler = PageHandler.new(url)
    page = handler.document
    return if page.nil?

    finder = AssetFinder.new(page)
    assets = finder.find_all
    assets.delete(parent_url)
   
    # assign_asset_to_closest_valid_parent 
    json.add(url, LinkUtils.valid_static_assets(assets)) unless assets.empty?

    crawled << url

    crawlable_child_urls = generate_crawlable_urls(assets) 

    crawlable_child_urls.each do |child_url|
      child_url = LinkUtils.preprocess_link(child_url)
      crawl(child_url) unless crawled.include?(child_url)
    end
  end

  def print
    puts json.print
  end

  private

  def crawled
    @crawled
  end

  def generate_crawlable_urls(assets)
    assets.map! { |asset| LinkUtils.preprocess_child_link(asset, parent_url) }
    assets.reject! { |asset| asset.include?("http") } 
    assets.map! { |asset| "#{parent_url}/#{asset}" }
    assets.reject! do |asset|
      asset.empty? ||
      crawled.include?(asset) ||
      !PageHandler.new(asset).valid? 
    end
    assets
  end

  def json
    @json ||= JSONHandler.new
  end

  def parent_url
    @parent_url
  end

end

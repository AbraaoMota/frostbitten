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
    puts "Crawling through: #{url} ..."
    url = LinkUtils.preprocess_link(url)
    return if crawled?(url)
    handler = PageHandler.new(url)
    page = handler.document
    return if page.nil?
    crawled << url

    finder = AssetFinder.new(page)
    assets = finder.find_all
    assets.delete(parent_url)
  
    add_assets(assets)
    crawlable_child_urls = LinkUtils.generate_crawlable_urls(assets, parent_url, crawled) 

    crawlable_child_urls.each do |child_url|
      child_url = LinkUtils.preprocess_link(child_url)
      crawl(child_url) unless crawled?(child_url)
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

  def crawled?(asset)
    crawled.include?(asset)
  end

  def add_assets(assets)
    valid_assets = LinkUtils.valid_static_assets(assets, parent_url)
    valid_assets.each do |valid_asset|
      direct_asset_parent = LinkUtils.get_direct_parent(valid_asset)
      
      if @indexed_parenting
        original_asset_parent = direct_asset_parent
        if !unindexed_subdir_to_indexed_parent.keys.include?(direct_asset_parent)
          while PageHandler.new(direct_asset_parent).open_page.nil? || direct_asset_parent != parent_url
            direct_asset_parent = LinkUtils.get_direct_parent(direct_asset_parent)
          end
          unindexed_subdir_to_indexed_parent[original_asset_parent] = direct_asset_parent 
        else
          direct_asset_parent = unindexed_subdir_to_indexed_parent[direct_asset_parent]
        end
      end
      json.add(direct_asset_parent, valid_asset)
    end
  end

  def unindexed_subdir_to_indexed_parent
    @unindexed_subdir_to_indexed_parent ||= {}
  end

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

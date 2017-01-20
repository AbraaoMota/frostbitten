module LinkUtils

  def self.preprocess_link(link)
    link = escape_spaces(link)
    remove_slash_suffix(link)
  end

  def self.valid_static_assets(assets, parent_url)
    static_assets = []
    static_asset_file_endings.each do |ending|
      assets.each do |asset|
        asset = preprocess_child_link(asset, parent_url)
        full_asset = "#{parent_url}/#{asset}"    
        static_assets << full_asset if asset_type(asset) == ".#{ending}"
      end
    end
    static_assets
  end

  def self.generate_crawlable_urls(assets, parent_url, crawled)
    assets.map!    { |asset| LinkUtils.preprocess_child_link(asset, parent_url) }
    assets.reject! { |asset| asset.include?("http") } 
    assets.map!    { |asset| "#{parent_url}/#{asset}" }
    assets.reject! { |asset| invalid_asset?(asset, crawled) }
    assets
  end

  def self.invalid_asset?(asset, crawled)
    asset.empty? ||
    crawled.include?(asset) ||
    !PageHandler.new(asset).valid?
  end

  def self.get_direct_parent_and_child(asset)
    return File.dirname(asset), File.basename(asset)
  end

  private 

  def self.asset_type(asset)
    File.extname(asset).downcase
  end

  def self.preprocess_child_link(link, parent_url)
    link = escape_spaces(link)
    remove_url_prefixes(link, parent_url)
  end

  def self.remove_url_prefixes(asset_name, parent_url)
    name = remove_parent_url(asset_name, parent_url)
    remove_leading_symbols(name)
  end


  def self.remove_leading_symbols(name)
    name[0] == '/' || name[0] == '#' ? name[1..name.length] : name
  end

  def self.remove_parent_url(name, parent_url)
    name.include?(parent_url) ? name[parent_url.size..name.size] : name
  end

  def self.escape_spaces(name)
    name.sub!(' ', '%20') if name.include? ' '
    name
  end

  def self.remove_slash_suffix(name)
    name = name[0..-2] if name.end_with? '/'
    name
  end

  def self.static_asset_file_endings
    [ "css", "js", "jpg", "jpeg", "png", "ico", "bmp", "pict" ]
  end

end

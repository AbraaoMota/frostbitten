module LinkUtils

  def self.preprocess_link(link)
    link = escape_spaces(link)
    remove_slash_suffix(link)
  end

  def self.preprocess_child_link(link, parent_url)
    link = escape_spaces(link)
    remove_url_prefixes(link, parent_url)
  end

  def self.remove_url_prefixes(asset_name, parent_url)
    name = remove_parent_url(asset_name, parent_url)
    remove_leading_symbols(name)
  end

  def self.valid_static_assets(assets)
    static_assets = []
    static_asset_file_endings.each do |ending|
      assets.each do |asset|
        asset = asset.downcase
        static_assets << asset if asset.end_with?(ending)
      end
    end
    static_assets
  end

  private 

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
    [ "css",
      "js",
      "jpg",
      "jpeg",
      "gif",
      "ico",
      "png",
      "bmp",
      "pict",
      "csv",
      "doc",
      "pdf",
      "pls",
      "ppt",
      "tif",
      "tiff",
      "eps",
      "ejs",
      "swf",
      "midi",
      "mid",
      "ttf",
      "eot",
      "woff",
      "otf",
      "svg",
      "svgz",
      "webp",
      "docx",
      "xlsx",
      "xls",
      "pptx",
      "ps",
      "class",
      "jar",
      "woff2"]
  end

end

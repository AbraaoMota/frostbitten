require 'json'

class JSONHandler

  attr_accessor :hash

  def initialize
    @hash = { "static_assets": [] }
  end

  def add(url, assets)
    hash_url_array = @hash[:static_assets].select { |item| item[:url] == url }
    if hash_url_array.empty?
      @hash[:static_assets] << { "url": url, "assets": [assets] }
    else
      url_assets = hash_url_array[0][:assets]
      url_assets << assets
      url_assets.uniq!
    end
  end

  def print
    JSON.generate(hash)
  end

  def print_pretty
    JSON.pretty_generate(hash)
  end
end

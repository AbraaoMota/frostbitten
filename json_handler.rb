require 'json'

class JSONHandler

  attr_accessor :hash

  def initialize
    @hash = { "static_assets": [] }
  end

  def add(url, assets)
    @hash[:static_assets] << { "url": url, "assets": assets }
  end

  def print
    JSON.generate(hash)
  end

end

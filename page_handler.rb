require 'nokogiri'
require 'open-uri'

class PageHandler
  
  def initialize(url)
    @url = url
  end

  def document
    Nokogiri::HTML(open(url))
  end

  private

  def url
    @url
  end

end

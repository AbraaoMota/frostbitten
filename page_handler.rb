require 'nokogiri'
require 'open-uri'

class PageHandler
  
  def initialize(url)
    @url = url
  end

  def document
    file = open(url)
    Nokogiri::HTML(file)

  rescue OpenURI::HTTPError => e
    if e.message == '404 Not Found'
      puts "This page does not exist! Skipping..."
      nil
    end
  rescue Exception => e
    puts e.message
    nil
  end

  def valid?
    url =~ URI::regexp
  end

  private

  def url
    @url
  end

end

require 'nokogiri'
require 'open-uri'

class PageHandler
  
  def initialize(url)
    @url = url
  end

  def open_page(quiet = false)
    puts "Crawling through: #{url} ..." unless quiet
    open(url)
  rescue OpenURI::HTTPError => e
    if e.message == '404 Not Found'
      puts "This page does not exist! Skipping..." unless quiet
      nil
    end
  rescue Exception => e
    puts e.message
    nil
  end

  def try_open
    open(url)
  rescue Exception => e
    nil
  end

  def document(quiet = false)
    file = open_page(quiet)
    Nokogiri::HTML(file)
  end

  def valid?
    url =~ URI::regexp
  end

  private

  def url
    @url
  end

end

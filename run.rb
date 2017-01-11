#!usr/bin/ruby

require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'pry'


parent_url = "https://gocardless.com"
page = Nokogiri::HTML(open(parent_url))

####################################
# Find 'a' links
####################################
links = page.css('a')
hrefs = []
links.each do |link|
  href = link.attributes["href"]
  if href == nil
    next
  end
  href_val = href.value
  hrefs << href_val unless href_val == nil || href_val.include?("http")
end

puts "\n\n ---- Links ----"
puts hrefs


#####################################
# Find js scripts / css stylesheets
#####################################
scripts = page.css('script')
resources = []
scripts.each do |script|
  src = script.attributes["src"]
  if src == nil 
    next
  end
  resource_val = src.value
  resources << resource_val
end

css_links = page.css('link')
css_links.each do |link|
  href = link.attributes["href"]
  if href == nil
    next
  end
  resource_val = href.value
  resources << resource_val
end

puts "\n\n ---- Scripts ---"
puts resources


###################################
# Find images 
###################################
images = page.css('img')
img_links = []
images.each do |image|
  src = image.attributes["src"]
  if src == nil 
    next
  end
  img_link = src.value
  img_links << img_link 
end

puts "\n\n ---- Images ---"
puts img_links



#!usr/bin/ruby

require_relative 'asset_finder'
require 'nokogiri' 
require 'open-uri'

# puts "Please enter the desired URL to crawl:"
# parent_url = gets.chomp


parent_url = "http://abraao.me"

page = Nokogiri::HTML(open(parent_url))
finder = AssetFinder.new(page)

puts "\n\n ---- Links ----"
puts finder.find_hyperlinks

puts "\n\n ---- Scripts ---"
puts finder.find_js_scripts
puts finder.find_css_stylesheets
puts "\n\n ---- Images ---"
puts finder.find_images


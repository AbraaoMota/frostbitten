#!usr/bin/ruby

require 'pry'
require_relative 'crawler'

puts "Please enter the desired URL to crawl:"
parent_url = gets.chomp

# parent_url = "http://abraao.me"

crawler = Crawler.new(parent_url)

# TODO: parse in user arguments (stdout json, save file options etc) 
crawler.crawl
crawler.print

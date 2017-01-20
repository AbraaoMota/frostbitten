#!usr/bin/ruby
require 'pry'
require_relative 'crawler'

# Parse user arguments
@pretty = false
@save = false
@indexed_parenting = false
ARGV.each do |arg|
  if arg == "-h" || arg == "--h" || arg == "-help" || arg == "--help"
    puts "\nTo ask for help pass \"-h\"\n\n"
    puts "Pass \"-pretty\" for well formatted JSON printed output\n\n"
    puts "Pass \"-save\" to save the JSON output to a file.\n\n"
    puts "Pass \"-indexed_parenting\" to format the output such that parent url's must be indexed (have an accessible page of their own) to own an asset."
    puts "The default is direct parenting, where a parent url may not necessarily be indexed, but owns only children directly in its directory.\n\n"
    exit 
  end
  if arg == "-pretty"
    @pretty = true
  end
  if arg == "-save"
    @save = true
  end
  if arg == "-indexed_parenting"
    @indexed = true
  end
end
ARGV.clear

puts "Please enter the desired URL to crawl:"
parent_url = gets.chomp
crawler = Crawler.new(parent_url, @indexed_parenting)
crawler.crawl
crawler.print(@pretty)
crawler.save if @save

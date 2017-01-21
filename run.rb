#!usr/bin/ruby
require 'pry'
require_relative 'crawler'

# Parse user arguments
@pretty = false
@save = false
@indexed_parenting = false
@quiet = false
ARGV.each do |arg|
  if arg == "-h" || arg == "--h" || arg == "-help" || arg == "--help"
    puts "\nTo ask for help pass \"-h\"\n\n"
    puts "Pass \"-pretty\" for well formatted JSON printed output\n\n"
    puts "Pass \"-save\" to save the JSON output to a file.\n\n"
    puts "Pass \"-indexed_parenting\" to format the output such that parent url's must be indexed (have an accessible page of their own) to own an asset."
    puts "The default is direct parenting, where a parent url may not necessarily be indexed, but owns only children directly in its directory.\n\n"
    puts "Pass \"-quiet\" for no output, pass this along with \"-save\" to quietly save output to a file.\n\n"
    exit 
  end
  if arg == "-pretty"
    @pretty = true
  end
  if arg == "-save"
    @save = true
  end
  if arg == "-indexed_parenting"
    @indexed_parenting = true
  end
  if arg == "-quiet"
    @quiet = true
  end
end
ARGV.clear

puts "Please enter the desired URL to crawl:"
parent_url = gets.chomp
crawler = Crawler.new(parent_url, @indexed_parenting, @quiet)
crawler.crawl
unless @quiet
  puts "\n\n ---- Final output ----"
  puts crawler.output(@pretty)
end
crawler.save(@pretty) if @save

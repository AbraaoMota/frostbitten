# frostbitten

## A simple recursive web crawler to find static assets in a website

### Installation

Make sure you have ruby installed, as well as bundler.
This was developed using ruby 2.3.3p222. After installing ruby, to install bundler run `gem install bundler` on your terminal.
You should then be able to make use of the Gemfile defined for the project.

### Usage

Firstly, after cloning the repository and following the installation requirements above, run `bundle install` to install dependencies defined for the project.

After this has completed, run the crawler by calling `ruby run.rb`. 
The crawler will first ask you for a url to crawl on. The output should be the static assets of the parent url given.


#### TODO
Identifiy valid sub links and recurse on those
Add RSPEC
User argument parsing
Error handling for user url input

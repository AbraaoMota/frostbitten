# frostbitten

## A simple recursive web crawler to find static assets in a website

### Installation

Make sure you have ruby installed, as well as bundler.
This was developed using ruby 2.3.3p222. After installing ruby, to install bundler run **`gem install bundler`** on your terminal.
You should then be able to make use of the Gemfile defined for the project. Clone the repository and run **`bundle install`** to install dependencies defined for the project.

### Usage

After this has completed, run the crawler by calling **`ruby run.rb`**. 
The crawler will first ask you for a url to crawl on. The output should be the static assets of the parent url given.

The crawler can parse different arguments, and you can choose whichever you want to use in any run; (**eg.** you can save quiet pretty output using **`ruby run.rb -save -quiet -pretty`**).

Run **`ruby run.rb -h`** for a quick reminder on the script usage.

**`ruby run.rb -pretty`** outputs the JSON in human readable format, without this flag the outputs saved into a file or printed will be in raw JSON.

**`ruby run.rb -quiet`** will silence any printing by the script, you may want to use this with the **`-save`** flag.

**`ruby run.rb -save`** will save the outputs into **`frostbitten_output.json`**. The saved contents will mirror the outputs depending on whether the pretty flag was passed or not.

**`ruby run.rb -indexed_parenting`** enables indexed parenting. This is a heuristic used to write outputs; by default the script will output the immediate parent of an asset, regardless of whether this parent is indexed on the internet (there is an accessible page for this parent page). Using indexed parenting, the script will look for the closest indexed parent to assign as the parent of an asset, all the way up to the initial url if none are found. 

As an example:

Suppose the asset http://example.org/css/all.css exists.

By default the script assigns the closest parent of this asset to be its owner, so http://example.org/css will be the parent of http://example.org/css/all.css.

If however this page (http://example.org/css) doesn't exist or cannot be accessed normally, the script will look further up for an indexed parent, in this case http://example.org.

### Testing
This app uses RSpec for unit testing.
To run the test suite, run **`rspec --format doc`** for some neat output.

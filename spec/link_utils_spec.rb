require_relative "../link_utils.rb"

RSpec.describe LinkUtils do

  describe "#preprocess_link" do
    
    let(:space_link) { "http:// abraao.me" }
    let(:slash_link) { "/blog/" }

    it "escapes spaces in links" do
      expect(LinkUtils.preprocess_link(space_link)).to eq("http://%20abraao.me")
    end

    it "removes a slash suffix if present" do
      expect(LinkUtils.preprocess_link(slash_link)).to eq("/blog")
    end
  end

  describe "#remove_url_prefixes" do

    let(:parent_url) { "http://example.com" }
    let(:child_url1) { "http://example.com/bloop" }
    let(:child_url2) { "#bloop" }
    let(:child_url3) { "/bloop" }

    it "removes the parent url from children url's" do
      expect(LinkUtils.remove_url_prefixes(child_url1, parent_url)).to eq("bloop")
    end

    it "removes slash prefixes" do
      expect(LinkUtils.remove_url_prefixes(child_url2, parent_url)).to eq("bloop")
    end

    it "removes hash prefixes" do
      expect(LinkUtils.remove_url_prefixes(child_url3, parent_url)).to eq("bloop")
    end
  end

  describe "#valid_static_assets" do
   
    let(:parent_url) { "http://example.com" } 
    let(:assets) { ["http://example.com/j.js",
                    "http://example.com/c.css",
                    "http://example.com/c.randomfile",
                    "http://example.com/cat.png"] }

    let(:valid_assets) { ["http://example.com/j.js",
                          "http://example.com/c.css",
                          "http://example.com/cat.png"] }


    it "returns valid static asset file types" do
      expect(LinkUtils.valid_static_assets(assets, parent_url)).to match_array(valid_assets) 
    end
  end

  describe "#invalid_asset?" do

    let(:crawled)     { ["http://example.com", "http://example.com/css"] }
    let(:empty_asset) { "" }
    let(:crawled_asset) { "http://example.com/css" }
    let(:mistyped_asset) { "://_www.__asdz" }
    let(:uncrawled_asset) { "http://example.com/css/a.jpg" }

    it "returns true for empty assets" do
      expect(LinkUtils.invalid_asset?(empty_asset, crawled)).to be true
    end

    it "returns true for assets which have already been crawled" do
      expect(LinkUtils.invalid_asset?(crawled_asset, crawled)).to be true
    end

    it "returns true if the asset does not confirm with valid url standards" do
      expect(LinkUtils.invalid_asset?(mistyped_asset, crawled)).to be true
    end

    it "returns false for valid, uncrawled assets" do
      expect(LinkUtils.invalid_asset?(uncrawled_asset, crawled)).to be false
    end
  end

  describe "#generate_crawlable_urls" do

    before(:each) do
      @assets = []
    end
 
    let(:parent_url) { "http://example.com" }
    let(:crawled)    { "http://example.com/css/cat.png" }

    let(:asset_with_spaces) { "css/ bloop.jpg" }
    let(:crawlable_space_asset) { "http://example.com/css/%20bloop.jpg" }

    it "escapes spaces from assets that have spaces" do
      @assets << asset_with_spaces
      crawlable_urls = LinkUtils.generate_crawlable_urls(@assets, parent_url, crawled)
      expect(crawlable_urls).to eq([crawlable_space_asset]) 
    end

    let(:slash_suffix_asset) { "#img" }
    let(:crawlable_slash_asset) { "http://example.com/img" }

    it "standardises assets by removing any url prefixes" do
      @assets << slash_suffix_asset
      crawlable_urls = LinkUtils.generate_crawlable_urls(@assets, parent_url, crawled)
      expect(crawlable_urls).to eq([crawlable_slash_asset])
    end

    let(:child_asset) { "bloop.png" }
    let(:full_asset)  { "http://example.com/bloop.png" }
    it "appends the parent url to the asset" do
      @assets << child_asset
      crawlable_urls = LinkUtils.generate_crawlable_urls(@assets, parent_url, crawled)
      expect(crawlable_urls).to eq([full_asset])
    end

    let(:empty_asset) { "" }

    it "rejects empty assets" do
      @assets << empty_asset
      crawlable_urls = LinkUtils.generate_crawlable_urls(@assets, parent_url, crawled)
      expect(crawlable_urls).to be_empty
    end

    let(:already_crawled_asset) { "http://example.com/css/cat.png" }

    it "rejects previously crawled assets" do
      @assets << already_crawled_asset
      crawlable_urls = LinkUtils.generate_crawlable_urls(@assets, parent_url, crawled)
      expect(crawlable_urls).to be_empty
    end

    let(:other_domain_asset) { "http://google.com/tagmanager" }

    it "rejects assets from other domains" do
@assets << other_domain_asset
      crawlable_urls = LinkUtils.generate_crawlable_urls(@assets, parent_url, crawled)
      expect(crawlable_urls).to be_empty
    end
  end
end


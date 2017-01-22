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
  end

end


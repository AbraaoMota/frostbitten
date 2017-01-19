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
    
    let(:assets) { ["http://example.com/j.js",
                    "http://example.com/c.css",
                    "http://example.com/c.randomfile",
                    "http://example.com/cat.png"] }

    let(:valid_assets) { ["http://example.com/j.js",
                          "http://example.com/c.css",
                          "http://example.com/cat.png"] }


    it "returns valid static asset file types" do
      expect(LinkUtils.valid_static_assets(assets)).to match_array(valid_assets) 
    end
  end

end


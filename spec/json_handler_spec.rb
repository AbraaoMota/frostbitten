require_relative "../json_handler"

RSpec.describe JSONHandler do

  before(:each) do
    @handler = JSONHandler.new
  end

  describe "#add" do

    let(:url) { "http://example.com" }
    let(:asset) { "http://example.com/css/c.css" }

    it "adds a new url and its assets to the hash" do
      @handler.add(url, asset)
      expect(@handler.hash[:static_assets][0][:assets][0]).to eq(asset)
    end

    let(:existing_url)   { "http://example.com" }
    let(:existing_asset) { "http://example.com/img/cat.jpg" }
    let(:new_asset)      { "http://example.com/img/dog.jpg" }
    let(:expected_hash)  { { "url": existing_url,
                             "assets": [ existing_asset, new_asset ] } }

    it "adds another asset to an existing list of assets" do
      @handler.add(existing_url, existing_asset)
      @handler.add(existing_url, new_asset)
      expect(@handler.hash[:static_assets][0]).to eq(expected_hash)
    end

  end

end

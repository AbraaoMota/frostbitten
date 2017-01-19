require_relative "../json_handler"

RSpec.describe JSONHandler do

  describe "#add" do

    let(:handler) { JSONHandler.new }
    let(:url) { "http://example.com" }
    let(:asset) { "http://example.com/css/c.css" }

    it "adds a url and its assets to the hash" do
      handler.add(url, asset)
      expect(handler.hash[:static_assets][0][:assets]).to eq(asset)
    end
  end

end

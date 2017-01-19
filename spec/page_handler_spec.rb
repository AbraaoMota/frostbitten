require_relative '../page_handler'

RSpec.describe PageHandler do

  describe "#document" do
    it "should return a html document object" do
      handler = PageHandler.new("http://abraao.me")
      document = handler.document
      is_html_document = document.instance_of?(Nokogiri::HTML::Document)

      expect(is_html_document).to be true
    end 
  end
end

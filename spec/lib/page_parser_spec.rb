require 'spec_helper'

describe ImageDownloader::PageParser do

  it "parse valid html" do
    body = <<-HTML
      <img src="http://example.com/img.png" />
      <img src="/img/img1.png" />
      <img src="/img1.png" />
      <img src="img1.png" />
    HTML
    ImageDownloader::PageParser.any_instance.stub(:get_page_body).and_return body
    images_url = ImageDownloader::PageParser.parse("http://example.com/a/")
    images_url.should == [
      "http://example.com/img.png",
      "http://example.com/img/img1.png",
      "http://example.com/img1.png",
      "http://example.com/a/img1.png",
    ]
  end

end

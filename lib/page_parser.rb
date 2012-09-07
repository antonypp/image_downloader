module ImageDownloader
  class PageParser

    def self.parse(url)
      pp = new url
      pp.parse
    end

    def initialize(url)
      @uri = create_uri(url)
    end

    def create_uri(url)
      url = ["http://", url].join unless url.match /http:\/\//
      URI(url)
    rescue
      raise "bad page url"
    end

    def get_page_body(uri)
      response = Net::HTTP.get_response(uri)
      raise "Can't load page" unless response.is_a? Net::HTTPSuccess
      response.body
    end

    def parse
      body = get_page_body @uri
      images_url = []
      body.scan(/<img.*?src=['"]{1}(.*?)['"]{1}/).uniq.each do |img|
        img = img.first
        img = [@uri.scheme, "://", @uri.host, img].join unless img.match(/^(\/.*?){0,}\/[^\/]*$/).nil?
        img = [@uri, img].join unless img.match(/^[^\/]*$/).nil?
        images_url << img
      end
      images_url
    end

  end
end

module ImageDownloader
  class Task

    def initialize(url, dir)
      @status = ""
      @url = url
      @dir = dir
      @thr = start
    end

    def join
      @thr.join if @thr
    end

    def complete?
      @status == "complete"
    end

    def error
      @error||''
    end

    private

    def start
      if valid_url?(@url)
        create_thread(@url)
      else
        @status = "error"
        @error = RuntimeError.new "Not valid url"
        false
      end
    end

    def create_thread(url)
      Thread.new do
        begin
          download_file(url)
          @status = "complete"
        rescue => error
          @status = "error"
          @error = error
        end
      end
    end

    def download_file(url)
      uri = URI(url)
      file_name = get_file_name(uri)
      Net::HTTP.start(uri.host, uri.port) do |http|
        request = Net::HTTP::Get.new uri.request_uri
        http.request request do |response|
          open file_name, 'wb' do |io|
            response.read_body do |chunk|
              io.write chunk
            end
          end
        end
      end
    end

    def get_file_name(uri)
      file_name = uri.path.split("/").last
      file_name = [@dir, file_name].join("/")
    end

    def valid_url?(url)
      URI(url).scheme == "http"
    rescue
      false
    end
  end
end

require 'net/http'
require "./lib/image_downloader"

url = ARGV[0]
dir = ARGV[1]

status = ImageDownloader.download_image_from_page(url, dir)
if status.any?
  c, e, errors = status
  p "complete: #{c}"
  p "error: #{e}"
end

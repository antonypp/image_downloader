module ImageDownloader
  autoload "DownloadManager", File.expand_path("lib/download_manager")
  autoload "Task", File.expand_path("lib/task")
  autoload "PageParser", File.expand_path("lib/page_parser.rb")

  def self.download_image_from_page(url, dir)
    dm = DownloadManager.new(dir)
    images_url = PageParser.parse(url)
    dm.add_tasks(images_url)
    dm.status
  rescue => e
    p e.to_s
    []
  end
end

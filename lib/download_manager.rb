module ImageDownloader
  class DownloadManager

    def initialize(dir)
      raise "Bad dir" unless Dir.exists?(dir)
      @dir = dir
      @tasks = []
    end

    def add_tasks(urls)
      urls.each do |url|
        add_task url
      end
    end

    def add_task(url)
      @tasks << Task.new(url, @dir)
    end

    def status
      @tasks.each {|t| t.join}
      c = 0
      e = 0
      errors = []
      @tasks.each do |task|
        if task.complete?
          c+=1
        else
          e+=1
          errors << task.error
        end
      end
      [c, e, errors]
    end
  end
end

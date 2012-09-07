require "spec_helper"

describe ImageDownloader::Task do

  it "create task should be valid" do
    ImageDownloader::Task.any_instance.stub(:download_file).and_return true
    task = ImageDownloader::Task.new("http://exemple.com/img.png", "./img")
    task.should be
  end

  it "end task should be complete" do
    ImageDownloader::Task.any_instance.stub(:download_file).and_return true
    task = ImageDownloader::Task.new("http://exemple.com/img.png", "./img")
    task.should be
    task.join
    task.should be_complete
  end

  it "end task should be error" do
    error = RuntimeError.new "test"
    ImageDownloader::Task.any_instance.stub(:download_file).and_raise error
    task = ImageDownloader::Task.new("http://exemple.com/img.png", "./img")
    task.should be
    task.join
    task.should_not be_complete
    task.error.should == error
  end

  it "not valid url error" do
    ImageDownloader::Task.any_instance.stub(:download_file).and_return true
    task = ImageDownloader::Task.new("htp://exemple.com/img.png", "./img")
    task.join
    task.should_not be_complete
    task.error.to_s.should == "Not valid url"
  end

end

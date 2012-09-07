require 'spec_helper'

describe ImageDownloader::DownloadManager do

  before :each do
    ImageDownloader::Task.any_instance.stub(:download_file).and_return true
    FileUtils.mkdir "./img"
  end

  after :each do
    FileUtils.remove_dir "./img", true
  end

  it "raise if bad dir" do
    lambda {
      ImageDownloader::DownloadManager.new("./new")
    }.should raise_exception
  end

  it "#add_tasks should ok" do
    images_url = ["http://example.com/img.png", "http://example.com/img1.png", "http://example.com/img2.png"]
    dm = ImageDownloader::DownloadManager.new("./img")
    dm.add_tasks images_url
    c, e, errors = dm.status
    c.should == 3
    e.should == 0
    errors.count.should == 0
  end

  it "#add_tasks should ok" do
    images_url = ["http//example.com/img.png", "http://example.com/img1.png", "http://example.com/img2.png"]
    dm = ImageDownloader::DownloadManager.new("./img")
    dm.add_tasks images_url
    c, e, errors = dm.status
    c.should == 2
    e.should == 1
    errors.count.should == 1
  end
end

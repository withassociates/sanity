require 'bundler/setup'
require 'rspec'
require 'net/http'
require 'open-uri'
require 'pry'

describe "A happy site" do
  let :base do
    'http://2012.withassociates.com'
  end

  let :request do
    Net::HTTP.new(base[7 .. -1], 80)
  end

  let :homepage do
    open "#{base}/"
  end

  def status_for(url)
    request.request_head url
  end

  it "has a meaningful title" do
    homepage.read.should include '<title>With Associates</title>'
  end

  it "has a meaningful description" do
    homepage.read.should include '<meta name="description"'
  end

  it "has open graph tags" do
    homepage.read.should include '<meta name="og:title"'
  end

  it "has twitter card tags" do
    homepage.read.should include '<meta name="twitter:site"'
  end

  it "has google analytics" do
    homepage.read.should include '_gaq'
  end

  it "has a favicon" do
    status_for('/favicon.ico').should == '200'
  end

  it "has a touch icon" do
    homepage.read.should include '<link rel="apple-touch-icon"'
  end

  it "has a default touch icon" do
    icons = %w(apple-touch-icon.png apple-touch-icon-precomposed.png)

    statuses = icons.collect { |icon| status_for('/' + icon).code }
    statuses.should include "200"
  end

  it "has an appropriate humans.txt" do
    status_for('/humans.txt').status.should == '200'
  end

  it "has an appropriate robots.txt" do
    status_for('/robots.txt').status.should == '200'
  end

  it "has a helpful 404 page" do
    open("#{base}/404.html").read.should include '404'
  end

  it "has a helpful 500 page" do
    open("#{base}/500.html").read.should include '500'
  end

  it "has all its domains registered with the font provider"
end

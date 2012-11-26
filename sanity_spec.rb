require 'bundler/setup'
require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.app_host = 'http://2012.withassociates.com'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.order = :random
end

describe "A happy site" do
  before do
    visit '/'
  end

  it "has a meaningful title" do
    page.should have_css 'title', :text => 'With Associates'
  end

  it "has a meaningful description" do
    page.should have_css 'meta[name="description"]'
  end

  it "has open graph tags" do
    page.should have_css 'meta[name="og:title"]'
  end

  it "has twitter card tags" do
    page.should have_css 'name[name="twitter:site]'
  end

  it "has google analytics" do
    page.body.should include '_gaq'
  end

  it "has a favicon"
  it "has a touch icon"
  it "has an appropriate humans.txt"
  it "has an appropriate robots.txt"
  it "has a helpful 404 page"
  it "has a helpful 500 page"
  it "has all its domains registered with the font provider"
end

require 'pry'

class Website
  attr_accessor :name, :url

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    #for future development, specs for the website being initialized could be loaded here
  end

  def scrape
    ns = Scraper.new.scrape_url(self, @url)
  end

  def self.all
    @@all
  end
end

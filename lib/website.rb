require 'pry'

class Website
  attr_accessor :name, :url
  include Memorable::InstanceMethods

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    #for future development, specs for the website being initialized could be loaded here
  end

  def self.create_find_by_name(name, url) 
    
    if Article.all.select{|article| article.website.name == name}.first == nil
      newsite = Website.new(name,url)
      newsite.save
    else
      newsite = Article.all.select{|article| article.name == name}.first
    end
    binding.pry
    newsite
  end

  def scrape
    if Article.website_scraped?(self) == false
      puts "will scrape"
      ns = Scraper.new.scrape_url(self, @url)
    end
  end

  def self.all
    @@all
  end
end

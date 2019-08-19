
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
    collection = Article.all.select{|article| article.website.name == name}.first
    if collection == nil
      newsite = Website.new(name,url)
      newsite.save
    else
      newsite = collection.website
    end
    newsite
  end

  def scrape
    if Article.website_scraped?(self) == false
      ns = Scraper.new
      ns.scrape_url(self, @url)
    end
  end

  def self.all
    @@all
  end
end

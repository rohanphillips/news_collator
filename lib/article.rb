class NewsCollator::Article
  attr_accessor :website, :headline, :description, :url, :comments, :views, :date_published
  @@all = []

  def initialize(article_info)
    #articles currently not checked for duplicate on new, can be expanded later
    article_info.each{|key, value| self.send(("#{key}="), value)}
    self.class.all << self
  end

  def self.website_scraped?(website)
    collection = all.select{|article| article.website.name == website.name}.first != nil
  end

  def self.all
    @@all
  end
end

require 'pry'

class Article
  attr_accessor :website, :headline, :description, :url, :comments, :views, :date_published
  @@all = []

  def initialize(article_info)
    article_info.each{|key, value| self.send(("#{key}="), value)}
    self.class.all << self
  end

  def self.website_scraped?(website)
    all.include?(website)
  end

  def self.all
    @@all
  end
end

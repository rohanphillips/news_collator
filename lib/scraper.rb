require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :errors

  def initialize
    @errors = false
  end

  def scrape_url(index_url, scrape_spec = {})
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    return_array = []
    f = doc.css(".views-row")

     f.each do |card|
      return_hash = {}
      comments = card.css(".extras__comments a span").textex
      head_line = card.css("h2.teaser-title span").text
      url = card.css("h2.teaser-title a").attribute("href").value
      description = card.css(".teaser-text p").text
      views = card.css(".teaser-details .extras__views span").text
      date_published = card.css(".extras__created span").text
      binding.pry

    #   return_hash[:location] = card.css(".student-location").text
    #   return_hash[:name] = card.css(".student-name").text
    #   return_hash[:profile_url] = card.css("a").attribute("href").value
    #   return_array << return_hash
    end
    return_array
  end

end

require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :errors

  def initialize
    @errors = false
  end

  def scrape_url(index_url, scrape_spec = {})
    binding.pry
    f = File.read(index_url)
    binding.pry
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    binding.pry
    return_array = []
    # student_card = doc.css(".student-card")
    # student_card.each do |card|
    #   return_hash = {}
    #   return_hash[:location] = card.css(".student-location").text
    #   return_hash[:name] = card.css(".student-name").text
    #   return_hash[:profile_url] = card.css("a").attribute("href").value
    #   return_array << return_hash
    # end
    return_array
  end

end

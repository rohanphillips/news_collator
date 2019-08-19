
class Scraper
  attr_accessor :errors

  def initialize
    @errors = false
  end

  def scrape_url(website, index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    return_hash = {}
    data_block = doc.css(".views-row")
    data_block.each do |card|
      return_hash.clear
      headline = card.css("h2.teaser-title span").text
      if headline != ""
        return_hash[:comments] = card.css(".extras__comments a span").text
        return_hash[:headline] = headline
        return_hash[:url] = card.css("h2.teaser-title a").attribute("href").value
        return_hash[:description] = card.css(".teaser-text p").text
        return_hash[:views] = card.css(".teaser-details .extras__views span").text
        return_hash[:date_published] = card.css(".extras__created span").text
        return_hash[:website] = website
        if data_block.size > 0
          Article.new(return_hash)
        end
      end
    end
  end
end

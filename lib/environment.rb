
require 'bundler/setup'
require 'pry'
require 'open-uri'
require 'nokogiri'
require 'colorize'
require "news_collator/version"
require "concerns/exit_art.rb"
require "concerns/memorable.rb"
require "website.rb"
require "article.rb"
require "scraper.rb"
require_relative "../lib/cli.rb"

module NewsCollator
  class Error < StandardError; end

  class NewsArticles

  end
end

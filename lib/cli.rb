require "environment.rb"
require 'pry'

class CLI
  attr_accessor :website

  include ExitArt::InstanceMethods

  def initialize
    @website = nil
  end

  def run
    menu_selection = 0
    menu_items = 3
    puts "Welcome to News Collator"
    while menu_selection >= 0 && menu_selection < menu_items
      puts "What would you like to do? (Enter number associated with you selection)"
      puts "1. Select Website to retrieve news from"
      Article.all.size > 0 ? (puts "2. Retrieve information relating to stories for #{@website.name}") :(puts "   ^------------^")
      puts "3. Exit"
      menu_selection = get_menu_selection(menu_items)
      case menu_selection
        when 1
          select_website
        when 2
          article_info_list
        when 3
          exit_art
      end
    end
  end

  def select_website
    sub_menu = 0
    menu_items = 2
    while sub_menu >= 0 && sub_menu < menu_items
      puts "Which site are you interested in?"
      puts "1. ZeroHedge - Locally saved Version"
      puts "2. ZeroHedge - Live Site"
      sub_menu = get_menu_selection(menu_items)
      case sub_menu
        when 1
          current_site = Website.create_find_by_name("Zerohedge - Local", "../news_collator_cli_gem/bin/test_files/zero.html")
          #/home/rohanphillips/temporary/news_collator_cli_gem/bin/test_files/zero.html
          @website = current_site
          current_site.scrape
          puts "Zerohedge - Local initialized, data is now ready \n"
          sub_menu = 3 #force menu exit
        when 2
          current_site = Website.create_find_by_name("Zerohedge", "https://www.zerohedge.com/")
          @website = current_site
          current_site.scrape
          puts "Zerohedge - Live initialized, data is now ready \n"
          sub_menu = 3 #force menu exit
      end
    end
  end

  def get_menu_selection(number_of_menu_items)
    menu_selection = 0
    menu_selection = gets.chomp.to_i
    if menu_selection == 0 || menu_selection > number_of_menu_items
      menu_selection = 0
      puts "Please enter a valid selection"
    end
    menu_selection
  end

  def article_info_list
    sub_menu = 0
    menu_items = 5
    while sub_menu >= 0 && sub_menu < menu_items
      puts "What data would you like to return?"
      puts "1. Sorted Article Headline list"
      puts "2. Sorted Article list by number of views"
      puts "3. Sorted Article list by number of comments"
      puts "4. Sorted Article list containing Headline Keyword"
      puts "5. Back to Main Menu"
      sub_menu = get_menu_selection(menu_items)
      case sub_menu
        when 1
          puts "Here's your sorted Article Headline list"
          collection = Article.all.select{|article| article.website.name == @website.name}.sort_by{|article| article.headline}
          article_list(collection)
        when 2
          puts "Here's your sorted Article list by number of views"
          collection = Article.all.select{|article| article.website.name == @website.name}.sort_by{|article| article.views}
          article_list(collection)
        when 3
          puts "Here's your sorted Article list by number of comments"
          collection = Article.all.select{|article| article.website.name == @website.name}.sort_by{|article| article.comments}
          article_list(collection)
        when 4
          puts "What Keyword would you like to search for?"
          keyword = gets.chomp.downcase
          collection = Article.all.select{|article| (article.website.name == @website.name && article.headline.downcase.include?(keyword) == true)

          }

          if collection.size > 0
            collection.sort_by{|article| article.headline}
            puts "Here's your sorted Article list containing your Keyword"
            article_list(collection)
          else
            puts "No results found for your keyword search - #{keyword}"
          end
      end
    end
  end

  def article_list(collection)
    sub_menu = 0
    while sub_menu >= 0 && sub_menu < collection.size
      collection.each_with_index{|article, index|
        puts "#{index + 1}. #{article.headline}"
      }
      puts "#{collection.size + 1}. Return to Prior Menu"
      puts "Select the Article you'd like additional info on"
      sub_menu = get_menu_selection(collection.size + 1)
      if sub_menu < collection.size + 1
        article_info(collection, sub_menu)
      end
    end
  end

  def article_available_elements(article)
    elements = []
    if article.description != ""
      elements << create_element_hash("description", "Description")
    end
    if article.url != ""
      elements << create_element_hash("url", "URL")
    end
    if article.comments != ""
      elements << create_element_hash("comments", "Number of Comments")
    end
    if article.views != ""
      elements << create_element_hash("views", "Number of times viewed")
    end
    if article.date_published != ""
      elements << create_element_hash("date_published", "Date / Time published")
    end
  end

  def create_element_hash(element, description)
    hash = {}
    hash[:name] = element
    hash[:description] = description
    hash
  end

  def article_info(collection, selection)
    sub_menu = 0
    available_elements = article_available_elements(collection[selection - 1])
    menu_items = available_elements.size + 1

    while (sub_menu >= 0 && sub_menu < menu_items)
      puts "What data would you like to return for this headline?"
      puts collection[selection - 1].headline

      available_elements.each_with_index do |element, index|
        puts "#{index + 1}. #{element[:description]}"
      end
      puts "#{available_elements.size + 1}. Return to Prior Menu"

      sub_menu = get_menu_selection(menu_items)
      if sub_menu <= available_elements.size
        puts "Here's the #{available_elements[sub_menu - 1][:description]} \n#{collection[selection - 1].instance_variable_get("@#{available_elements[sub_menu - 1][:name]}")}\n"
      end
    end
  end
end

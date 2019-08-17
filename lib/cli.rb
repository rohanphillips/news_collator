require "environment.rb"
require 'pry'

class CLI
  @website = 0
  extend ExitArt::ClassMethods

  def run
    menu_selection = 0
    menu_items = 3
    puts "Welcome to News Collator"
    while menu_selection >= 0 && menu_selection < menu_items
      puts "What would you like to do? (Enter number associated with you selection)"
      puts "1. Select Website to retrieve news from"
      Article.all.size > 0 ? (puts "2. Retrieve information relating to stories") :(puts "   ^------------^")
      puts "3. Exit"
      menu_selection = get_menu_selection(menu_items)
      case menu_selection
        when 1
          select_website
        when 2
          article_info_list
        when 3
          CLI.exit_art
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

  def select_website
    sub_menu = 0
    menu_items = 1
    while sub_menu >= 0 && sub_menu < menu_items
      puts "Which site are you interested in?"
      puts "1. ZeroHedge"
      sub_menu = get_menu_selection(menu_items)
      case sub_menu
        when 1
          current_site = Website.create_find_by_name("Zerohedge", "/home/rohanphillips/temporary/news_collator_cli_gem/bin/test_files/zero.html")
          @website = current_site
          current_site.scrape
          puts "Zerohedge initialzed, data is now ready \n"
      end
    end
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

  def article_info(collection, selection)
    sub_menu = 0
    menu_items = 6
    will_exit = false
    while (sub_menu >= 0 && sub_menu < menu_items) && will_exit == false
      puts "What data would you like to return for this headline?"
      puts collection[selection - 1].headline
      puts "1. Description"
      puts "2. URL"
      puts "3. Number of Comments"
      puts "4. Number of times viewed"
      puts "5. Date / Time published"
      puts "6. return to Prior Menu"

      sub_menu = get_menu_selection(menu_items)
      case sub_menu
        when 1
          puts "Here's the description \n#{collection[selection - 1].description}\n"
        when 2
          puts "Here's the URL \n#{collection[selection - 1].url}\n"
        when 3
          puts "Here's the Number of Comments \n#{collection[selection - 1].comments}\n"
        when 4
          puts "Here's the Number of times viewed \n#{collection[selection - 1].viewed}\n"
        when 5
          puts "Here's the Date / Time published \n#{collection[selection - 1].date_published}\n"
        when 6
          will_exit = true
      end
    end
  end
end

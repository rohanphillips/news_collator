require "pry"

class MenuController
  @website = 0

  def initialize
  end

  def main
    menu_selection = 0
    puts "Welcome to News Collator"
    while menu_selection >= 0 && menu_selection < 3
      puts "What would you like to do? (Enter number associated with you selection)"
      puts "1. Select Website to retrieve news from"
      Article.all.size > 0 ? (puts "2. Retrieve information relating to stories") :(puts "   ^------------^")
      puts "3. Exit"
      menu_selection = get_menu_selection(3)
      if menu_selection == 1
        select_website
      elsif menu_selection == 2
        article_info_list
      elsif menu_selection == 3
        puts "You rocked it!  Goodbye!"
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
    while sub_menu >= 0 && sub_menu < 1
      puts "Which site are you interested in?"
      puts "1. ZeroHedge"
      sub_menu = get_menu_selection(1)
      if sub_menu == 1
        current_site = Website.create_find_by_name("Zerohedge", "/home/rohanphillips/temporary/news_collator_cli_gem/bin/test_files/zero.html")
        @website = current_site
        current_site.scrape
        puts "Zerohedge initialzed, data is now ready \n"
      end
    end
  end

  def article_info_list
    puts "What data would you like to return?"
    puts "1. Sorted Article Headline list"
    puts "2. Back to Main Menu"
    sub_menu = get_menu_selection(2)
    if sub_menu == 1
      puts "Here's your sorted Article Headline list"
      collection = Article.all.select{|article| article.website.name == @website.name}.sort_by{|article| article.headline}
      article_list(collection)
    end

    def article_list(collection)
      sub_menu = 0
      while sub_menu >= 0 && sub_menu < collection
        collection.each_with_index{|article, index|
          puts "#{index + 1}. #{article.headline}"
        }
        puts "#{collection.size + 1}. Prior Menu"
        puts "Select the Article you'd like additional info on"
        sub_menu = get_menu_selection(collection.size + 1)
        puts "put menu to get info for selected article here"
      end
    end
  end


end

require "environment.rb"
require 'pry'

class CLI
  @website = 0
  def run
    menu = MenuController.new
    menu.main
    # menu_selection = 0
    # puts "Welcome to News Collator"
    # while menu_selection >= 0 && menu_selection < 3
    #   puts "What would you like to do? (Enter number associated with you selection)"
    #   puts "1. Select Wesite to retrieve news from"
    #   puts "2. Retrieve information relating to stories"
    #   puts "3. Exit"
    #   menu_selection = gets.chomp.to_i
    #   if menu_selection == 0 || menu_selection > 3
    #     menu_selection = 0
    #     puts "Please enter a valid selection"
    #   elsif menu_selection == 1
    #     sub_menu_1 = 0
    #     while sub_menu_1 >= 0 && sub_menu_1 < 1
    #       puts "Which site are you interested in?"
    #       puts "1. ZeroHedge"
    #       sub_menu_1 = gets.chomp.to_i
    #       if sub_menu_1 == 0 || sub_menu_1 > 1
    #         sub_menu_1 = 0
    #         puts "Please make a valid selection"
    #       elsif sub_menu_1 == 1
    #           current_site = Website.create_find_by_name("Zerohedge", "/home/rohanphillips/temporary/news_collator_cli_gem/bin/test_files/zero.html")
    #           @website = current_site
    #           current_site.scrape
    #           puts "Zerohedge initialzed, data is now ready"
    #       end
    #     end
    #   elsif menu_selection == 2
    #     menu_selection = 0
    #     sub_menu_2 = 0
    #     can_exit = false
    #     while (sub_menu_2 >= 0 && sub_menu_2 < 2) && can_exit == false
    #
    #       puts "What data would you like to return?"
    #       puts "1. Sorted Article Headline list"
    #       puts "2. Back to Main Menu"
    #       sub_menu_2 = gets.chomp.to_i
    #       if sub_menu_2 == 0 || sub_menu_2 > 2
    #         sub_menu_2 = 0
    #         puts "Please make a valid selection"
    #       elsif sub_menu_2 == 1
    #         puts "Here's your sorted Article Headline list"
    #         collection = Article.all.select{|article| article.website.name == @website.name}.sort_by{|article| article.headline}
    #         collection.each_with_index{|article, index|
    #           puts "#{index + 1}. #{article.headline}"
    #         }
    #         puts "Select the Article you'd like additional info on"
    #         sub_menu_3 = 0
    #         while sub_menu_3 >= 0 && sub_menu_3 < collection.size
    #           puts "Select the additional information about this article you'd like displayed"
    #           puts "1. ZeroHedge"
    #           sub_menu_3 = gets.chomp.to_i
    #           if sub_menu_3 == 0 || sub_menu_3 > collection.size
    #             sub_menu_3 = 0
    #             puts "Please make a valid selection"
    #           elsif sub_menu_3 == 1
    #               current_site = Website.create_find_by_name("Zerohedge", "/home/rohanphillips/temporary/news_collator_cli_gem/bin/test_files/zero.html")
    #               @website = current_site
    #               current_site.scrape
    #               puts "Zerohedge initialzed, data is now ready"
    #           end
    #         end
    #       elsif sub_menu_2 == 2
    #         can_exit = true
    #       end
    #     end
    #   elsif menu_selection == 3
    #     puts "You rocked it!  Goodbye!"
    #   end

  end
end

require "environment.rb"
require 'pry'

class CLI
  @site = 0
  def run
    menu_selection = 0
    puts "Welcome to News Collator"
    while menu_selection >= 0 && menu_selection < 3
      puts "What would you like to do? (Enter number associated with you selection)"
      puts "1. Select Wesite to retrieve news from"
      puts "2. Retrieve information relating to stories"
      puts "3. Exit"
      menu_selection = gets.chomp.to_i
      if menu_selection == 0 || menu_selection > 3
        menu_selection = 0
        puts "Please enter a valid selection"
      elsif menu_selection == 1
        sub_menu_1 = 0
        while sub_menu_1 >= 0 && sub_menu_1 < 1
          puts "Which site are you interested in?"
          puts "1. ZeroHedge"
          sub_menu_1 = gets.chomp.to_i
          if sub_menu_1 == 0 || sub_menu_1 > 1
            sub_menu_1 = 0
            puts "Please make a valid selection"
          elsif sub_menu_1 = 1
              current_site = Website.create_find_by_name("Zerohedge", "/home/rohanphillips/temporary/news_collator_cli_gem/bin/test_files/zero.html")
              @site = current_site
              current_site.scrape
              puts "Zerohedge initialzed, data is now ready"
          end
        end
        # newscraper = Scraper.new()
        # newscraper.scrape_url("/home/rohanphillips/temporary/news_collator_cli_gem/bin/test_files/zero.html")
      elsif menu_selection == 2

      elsif menu_selection == 3
        puts "You rocked it!  Goodbye!"
      end

    end
  end
end

require 'pry'

class CLI
  def run
    menu_selection = 0
    puts "Welcome to News Collator"
    while menu_selection >= 0 && menu_selection < 3
      puts "What would you like to do? (Enter number associated with you selection)"
      puts "1. Scrape New Stories"
      puts "2. Retrieve information relating to stories"
      puts "3. Exit"
      menu_selection = gets.chomp.to_i
      if menu_selection == 0 || menu_selection > 3
          menu_selection = 0
          puts "Please enter a valid selection"
      end
    end
  end
end

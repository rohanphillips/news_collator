
class CLI
  attr_accessor :website
  include AsciiArt::InstanceMethods

  def initialize
    @website = nil
  end

  def run
    menu_collection = []
    menu_selection = 0
    menu_items = 1
    welcome_art
    while menu_selection >= 0 && menu_selection < menu_items
      menu_collection.clear
      puts "What would you like to do?".light_green + " (Enter number associated with you selection)\n".light_cyan
      menu_collection << create_menu_hash("select", "Select Website to retrieve news from")
      Article.all.size > 0 ? (menu_collection << create_menu_hash("retrieve", "Retrieve information relating to stories for #{@website.name}")) :()
      menu_collection << create_menu_hash("exit", "Exit")
      menu_items = menu_collection.size
      create_menu(menu_collection, "light_green")
      menu_selection = get_menu_selection(menu_items)
      case menu_collection[menu_selection - 1][:action]
      when "select"
          select_website
        when "retrieve"
          article_info_list
        when "exit"
          exit_art
      end
    end
  end

  def create_menu_hash(action, text)
    menu_hash = {}
    menu_hash[:action] = action
    menu_hash[:text] = text
    menu_hash
  end

  def create_menu(collection, color)
    collection.each_with_index do |message_hash, index|
      puts "#{index + 1}.".colorize(:"#{color}") + message_hash[:text].colorize(:"#{color}")
    end
  end

  def select_website
    menu_collection =[]
    menu_selection = 0
    menu_items = 2
    while menu_selection >= 0 && menu_selection < menu_items
      menu_collection.clear
      puts "\nWhich site are you interested in?".light_blue
      menu_collection << create_menu_hash("zhlocal", "ZeroHedge - Locally saved Version")
      menu_collection << create_menu_hash("zhlive", "ZeroHedge - Live Site")
      menu_items = menu_collection.size
      create_menu(menu_collection, "light_blue")
      menu_selection = get_menu_selection(menu_items)
      case menu_collection[menu_selection - 1][:action]
      when "zhlocal"
          current_site = Website.create_find_by_name("Zerohedge - Local", "../news_collator_cli_gem/bin/test_files/zero.html")
          #/home/rohanphillips/temporary/news_collator_cli_gem/bin/test_files/zero.html
          @website = current_site
          current_site.scrape
          puts "Zerohedge - Local initialized, data is now ready\n".light_yellow
          menu_selection = 3 #force menu exit
        when "zhlive"
          current_site = Website.create_find_by_name("Zerohedge", "https://www.zerohedge.com/")
          @website = current_site
          current_site.scrape
          puts "Zerohedge - Live initialized, data is now ready \n"
          menu_selection = 3 #force menu exit
      end
    end
  end

  def get_menu_selection(number_of_menu_items)
    menu_selection = 0
    menu_selection = gets.chomp.to_i
    if menu_selection == 0 || menu_selection > number_of_menu_items
      menu_selection = 0
      puts "Please enter a valid selection".red
    end
    menu_selection
  end

  def article_info_list
    menu_collection = []
    menu_selection = 0
    menu_items = 1
    while menu_selection >= 0 && menu_selection < menu_items
      menu_collection.clear
      puts "\nSelect the data you'd like to display".light_blue
      menu_collection << create_menu_hash("sorted_article_list", "Sorted Article Headline list")
      menu_collection << create_menu_hash("sorted_by_views", "Sorted Article list by number of views")
      menu_collection << create_menu_hash("sorted_by_comments", "Sorted Article list by number of comments")
      menu_collection << create_menu_hash("get_keyword", "Sorted Article list containing Headline Keyword")
      menu_collection << create_menu_hash("back", "Back to Main Menu")
      menu_items = menu_collection.size
      create_menu(menu_collection, "light_blue")
      menu_selection = get_menu_selection(menu_items)
      case menu_collection[menu_selection - 1][:action]
        when "sorted_article_list"
          puts "\nHere's your sorted Article Headline list".magenta
          collection = Article.all.select{|article| article.website.name == @website.name}.sort_by{|article| article.headline}
          article_list(collection, "magenta")
        when "sorted_by_views"
          puts "\nHere's your sorted Article list by number of views".magenta
          collection = Article.all.select{|article| article.website.name == @website.name}.sort_by{|article| article.views}
          article_list(collection, "magenta")
        when "sorted_by_comments"
          puts "\nHere's your sorted Article list by number of comments".magenta
          collection = Article.all.select{|article| article.website.name == @website.name}.sort_by{|article| article.comments}
          article_list(collection, "magenta")
        when "get_keyword"
          puts "\nWhat Keyword would you like to search for?".magenta
          keyword = gets.chomp.downcase
          collection = Article.all.select{|article| (article.website.name == @website.name && article.headline.downcase.include?(keyword) == true)

          }

          if collection.size > 0
            collection.sort_by{|article| article.headline}
            puts "\nHere's your sorted Article list containing your Keyword".magenta
            article_list(collection, "magenta")
          else
            puts "\nNo results found for your keyword search - #{keyword}".red
          end
      end
    end
  end

  def article_list(collection, color)
    sub_menu = 0
    while sub_menu >= 0 && sub_menu < collection.size
      collection.each_with_index{|article, index|
        puts "#{index + 1}. #{article.headline}".colorize(:"#{color}")
      }
      puts "#{collection.size + 1}. Return to Prior Menu".colorize(:"#{color}")
      puts "\nSelect the Article you'd like additional info on\n".colorize(:"#{color}")
      sub_menu = get_menu_selection(collection.size + 1)
      if sub_menu < collection.size + 1
        article_info(collection, sub_menu, "yellow")
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

  def article_info(collection, selection, color)
    sub_menu = 0
    available_elements = article_available_elements(collection[selection - 1])
    menu_items = available_elements.size + 1

    while (sub_menu >= 0 && sub_menu < menu_items)
      puts "\nWhat data would you like to return for this headline?\n".colorize(:"#{color}")
      puts collection[selection - 1].headline.colorize(:"#{color}")

      available_elements.each_with_index do |element, index|
        puts "#{index + 1}. #{element[:description]}".colorize(:"#{color}")
      end
      puts "#{available_elements.size + 1}. Return to Prior Menu".colorize(:"#{color}")

      sub_menu = get_menu_selection(menu_items)
      if sub_menu <= available_elements.size
        puts "Here's the #{available_elements[sub_menu - 1][:description]} \n#{collection[selection - 1].instance_variable_get("@#{available_elements[sub_menu - 1][:name]}")}\n".colorize(:"#{color}")
      end
    end
  end
end

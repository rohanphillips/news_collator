require "environment.rb"
require 'pry'

class CLI

  def run
    menu = MenuController.new
    menu.main
    #menu.exit_art
  end
end

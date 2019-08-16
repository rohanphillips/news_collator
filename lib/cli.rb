require "environment.rb"
require 'pry'

class CLI

  def run
    menu = MenuController.new
    menu.main
  end
end

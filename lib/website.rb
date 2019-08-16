require 'pry'

class Website
  attr_accessor :name

  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  @@all = []

  def initialize(name)
    super
    @name = name
  end

  def self.all
    @@all
  end
end

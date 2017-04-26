require 'require_all'
require_all 'init.rb'

presence = FactoryGirl.create :presence

binding.pry if ENV['DEBUG'].present?

puts "foo"

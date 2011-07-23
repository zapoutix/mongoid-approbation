require "rubygems"
require "bundler/setup"

require "database_cleaner"
require "rspec"

require File.expand_path("../../lib/mongoid/approbation", __FILE__)

Mongoid.configure do |config|
  name = "mongoid_approbation_test"
  config.master = Mongo::Connection.new.db(name)
end

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |f| require f }

RSpec.configure do |c|
  c.before(:all)  { DatabaseCleaner.strategy = :truncation }
  c.before(:each) { DatabaseCleaner.clean }
end

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid/approbation/version"

Gem::Specification.new do |s|
  s.name        = "mongoid_approbation"
  s.version     = Mongoid::Approbation::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mathieu ATTAL"]
  s.email       = ["mathieu.attal@gmail.com"]
  s.homepage    = ""
  s.summary     = "Generates a URL approbation"
  s.description = "Mongoid Approbation"

  s.rubyforge_project = "mongoid_approbation"

  s.add_dependency("mongoid", "~> 2.0")
  s.add_development_dependency("database_cleaner", "~> 0.6")
  s.add_development_dependency("rspec", "~> 2.6")

  s.files         = Dir.glob("lib/**/*") + %w(LICENSE README.md)
  s.test_files    = Dir.glob("spec/**/*")
  s.require_paths = ["lib"]
end

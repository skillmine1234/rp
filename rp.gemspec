$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rp"
  s.version     = Rp::VERSION
  s.authors     = ["divyajayan"]
  s.email       = ["divya.jayan@quantiguous.com"]
  s.homepage    = "http://rubygems.org/gems/rp"
  s.summary     = "Customized report builder"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 7.0.4"
  s.add_dependency 'haml-rails'
  s.add_dependency 'will_paginate'
  s.add_dependency 'net-scp'
  s.add_dependency 'pundit'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'database_cleaner'
end

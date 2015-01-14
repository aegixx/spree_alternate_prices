# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_alternate_prices'
  s.version     = '2.4.2.3'
  s.summary     = 'Spree Alternate Prices - Provides alternate variant prices (with multi-currency)'
  s.description = 'Provides multiple prices for variants based on category; custom calculator provided.'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Bryan Stone'
  s.email     = 'bryan.stone@kailosgenetics.com'
  s.homepage  = 'http://www.kailosgenetics.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.4.2'
  s.add_dependency 'spree_multi_currency', '>= 2.2.0'

  s.add_development_dependency 'capybara', '~> 2.4'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.1'
  s.add_development_dependency 'rspec-expectations'
  s.add_development_dependency 'sass-rails', '~> 4.0.2'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end

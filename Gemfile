source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'
# Use postgres as DB
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.2', '>= 4.2.2'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6.0.0'
# Bootstrap styling
gem 'bootstrap-sass', '~> 3.4.1' 
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# For debugging
gem 'pry'

# Font awesome icons
gem 'font-awesome-sass', '~> 5.12.0'

# Pagination
gem 'will_paginate'
gem 'bootstrap-will_paginate', '1.0.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.0.2'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.32.2'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '>= 4.4.1'
  # RSpec testing
  gem 'rspec-rails', '~> 4.0.1'
  # Factory bot for tests
  gem 'factory_bot_rails', '>= 5.2.0'
  # Code coverage
  gem 'codecov'
end
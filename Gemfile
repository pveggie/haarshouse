source 'https://rubygems.org'
ruby '2.3.3'

gem 'rails', '~>4.2.10'
gem 'puma'
gem 'pg', '~> 0.18.0'
gem 'jbuilder', '~> 2.0'
gem 'redis'

gem 'sass-rails'
gem 'jquery-rails'
gem 'uglifier' #minifies javascript
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'simple_form'
gem 'autoprefixer-rails', '~> 8.1.0'
gem 'haar_joke'
# gem 'haar_joke', path: '~/code/pveggie/haar_joke'
gem 'pg_search'
gem 'devise'
gem 'figaro'

group :development, :test do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'spring'
  gem 'rspec-rails', '~> 3.4'
  # https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails'
  gem 'webmock'
end

group :test do
  # https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers', '~> 3.1'
  # https://github.com/jdliss/shoulda-callback-matchers
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'faker'
  gem 'capybara'
  gem 'poltergeist'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'database_cleaner'
  # gem 'capybara-webkit'
  # gem 'selenium-webdriver'
  gem 'guard-rspec'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end

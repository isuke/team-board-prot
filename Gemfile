source 'https://rubygems.org'
source 'https://rails-assets.org'
ruby '2.1.5'

ENV['NOKOGIRI_USE_SYSTEM_LIBRARIES'] = 'YES'

gem 'rails', '4.1.6'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'bcrypt', '~> 3.1'

gem 'bootstrap-sass'
gem 'diffy'

gem 'rails-assets-marked'
gem 'rails-assets-vue'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'faker'
  gem 'factory_girl_rails'
end

group :development do
  gem "pry"
  gem "pry-rails"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara', git: 'git://github.com/jnicklas/capybara.git'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

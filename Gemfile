# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.4.12'

rails_version = '~> 8.1'
gem 'actionpack', rails_version
gem 'actionview', rails_version
gem 'activemodel', rails_version
gem 'activerecord', rails_version
gem 'railties', rails_version

gem 'amqp'
gem 'erubis'
gem 'eventmachine'
gem 'honeybadger'
gem 'listen'

gem 'net-smtp'
gem 'observer'
gem 'psych', '< 4'
gem 'webrick'

gem 'hashie'

gem 'pg'

gem 'nokogiri'
gem 'rack'

group :test do
  gem 'byebug'
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'mocha', require: false
  gem 'rspec-rails'
  gem 'rubocop-rails-omakase', require: false
  gem 'rubocop-rspec'
end

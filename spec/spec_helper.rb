# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'

require File.join( [File.dirname(__FILE__), "..", 'config/environment' ]) unless defined?(Rails)
require 'rspec/rails'
require 'factory_bot'
require 'database_cleaner'
require 'mocha/setup'
require 'pp'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Transactional Fixtures don't work with sqlite.
  config.use_transactional_fixtures = false
  config.use_instantiated_fixtures  = false
  config.fixture_path = "#{File.dirname(__FILE__)}/fixtures"
  config.infer_base_class_for_anonymous_controllers = true

  config.mock_with :mocha

  config.color = true
  config.formatter = :documentation
end

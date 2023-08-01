if ENV['HONEYBADGER_API_KEY'].present?
  Honeybadger.configure do |config|
    config.api_key = ENV['HONEYBADGER_API_KEY']
  end
end
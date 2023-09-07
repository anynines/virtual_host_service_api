require 'yaml'
require 'erubis'

APP_CONFIG = VirtualHostService.config

if APP_CONFIG['honeybadger_api_key'].present?
  Honeybadger.configure do |config|
    config.api_key = APP_CONFIG['honeybadger_api_key']
  end
end

Rails.application.credentials = APP_CONFIG

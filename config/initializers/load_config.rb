require 'yaml'
require 'erubis'

APP_CONFIG = VirtualHostService.config
APP_CONFIG['amqp'] = YAML.load(Erubis::Eruby.new(File.read(Rails.root.join('config/amqp.yml'))).result)[Rails.env].symbolize_keys

if APP_CONFIG['honeybadger_api_key'].present?
  Honeybadger.configure do |config|
    config.api_key = APP_CONFIG['honeybadger_api_key']
  end
end

Rails.application.credentials = APP_CONFIG

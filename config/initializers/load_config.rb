require 'yaml'
require 'erubis'

APP_CONFIG = YAML.load_file(Rails.root.join('config/application.yml'))[Rails.env]
APP_CONFIG['amqp'] = YAML.load(Erubis::Eruby.new(File.read(Rails.root.join('config/amqp.yml'))).result)[Rails.env].symbolize_keys
  
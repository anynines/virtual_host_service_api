require 'yaml'

APP_CONFIG = YAML.load_file(Rails.root.join('config/application.yml'))[Rails.env]
APP_CONFIG['amqp'] = YAML.load_file(Rails.root.join('config/amqp.yml'))[Rails.env]

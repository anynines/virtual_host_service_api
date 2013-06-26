require 'yaml'

APP_CONFIG = YAML.load_file(Rails.root.join('config/application.yml'))[Rails.env]

class VirtualHostService::Configuration < Hashie::Dash
  include Singleton
  include Hashie::Extensions::IndifferentAccess
  include Hashie::Extensions::IgnoreUndeclared

  def self.config_path
    Rails.root.join('config/application.yml')
  end

  def initialize
    if File.exist?(self.class.config_path)
      yaml = YAML.load_file(self.class.config_path)[Rails.env]
      super(yaml)
    else
      super
    end

    return unless File.exist?(Rails.root.join('config/amqp.yml'))

    self.raw_amqp = YAML.load(Erubis::Eruby.new(File.read(Rails.root.join('config/amqp.yml'))).result)[Rails.env]
  end

  property :secret_key_base, default: 'xxx'
  property(
    :active_record_encryption,
    default: {
      primary_key: 'xxx',
      deterministic_key: 'xxx',
      key_derivation_salt: 'xxx'
    }
  )
  property  :honeybadger_api_key, default: ''
  property  :amqp_channel, default: 'virtual_host_jobs'
  property  :api_keys, default: {   customer_partal: 'FGaNYNkgvQ' }

  property(
    :raw_amqp,
    default: {
      user: begin
        JSON.parse(ENV.fetch('VCAP_SERVICES', nil))['a9hcp-rabbitmq'].first['credentials']['username']
      rescue StandardError
        ''
      end,
      pass: begin
        JSON.parse(ENV.fetch('VCAP_SERVICES', nil))['a9hcp-rabbitmq'].first['credentials']['password']
      rescue StandardError
        ''
      end,
      host: begin
        JSON.parse(ENV.fetch('VCAP_SERVICES', nil))['a9hcp-rabbitmq'].first['credentials']['host']
      rescue StandardError
        'localhost'
      end,
      vhost: '/'
    }
  )

  def amqp
    raw_amqp.symbolize_keys
  end
end

class VirtualHostService::Configuration < Hashie::Dash
  include Singleton
  include Hashie::Extensions::IndifferentAccess
  include Hashie::Extensions::IgnoreUndeclared


  def self.config_path
    Rails.root.join('config/application.yml')
  end

  def initialize
    if File.exists?(self.class.config_path)
      yaml = YAML.load_file(self.class.config_path)[Rails.env]
      super(yaml)
    else
      super
    end

    if File.exists?(Rails.root.join('config/amqp.yml'))
      self.raw_amqp = YAML.load(Erubis::Eruby.new(File.read(Rails.root.join('config/amqp.yml'))).result)[Rails.env]
    end
  end

  property :secret_key_base, default: 'xxx'
  property(
    :active_record_encryption,
    default: {
      primary_key: "xxx",
      deterministic_key: "xxx",
      key_derivation_salt: "xxx"
    })
  property  :honeybadger_api_key, default: ''
  property  :amqp_channel, default: 'virtual_host_jobs'
  property  :api_keys, default: {   customer_partal: 'FGaNYNkgvQ'}

  property(
    :raw_amqp, 
    default: {
      user: (JSON.parse( ENV['VCAP_SERVICES'] )['a9hcp-rabbitmq'].first['credentials']['username'] rescue ''),
      pass: (JSON.parse( ENV['VCAP_SERVICES'] )['a9hcp-rabbitmq'].first['credentials']['password'] rescue ''),
      host: (JSON.parse( ENV['VCAP_SERVICES'] )['a9hcp-rabbitmq'].first['credentials']['host'] rescue 'localhost'),
      vhost: '/'
    }
  )

  def amqp
    self.raw_amqp.symbolize_keys
  end

end

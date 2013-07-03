require 'openssl'

##
# This class contains informations neccessary to extend a webserver configuration
# with a virtual host able to terminate a ssl certificate. This class mainly aims to
# perform some validation on the imput data rather than write the webserver config.
# Instead of writing the webserver config it will push the data to a queue and
# leave the job to a worker.
class VHost < ActiveRecord::Base
  
  SERVER_NAME_REGEX = /^([a-zA-Z0-9]([a-zA-Z0-9\-])*[a-zA-Z0-9]\.)*([A-Za-z0-9]([A-Za-z0-9\-])*[A-Za-z0-9])\.([A-Za-z0-9]([A-Za-z0-9\-])*[A-Za-z0-9])$/
  
  attr_accessible :organization_guid, :server_name, :ssl_ca_certificate, :ssl_certificate, :ssl_key, :server_aliases
  
  validates :server_name, :uniqueness => { :case_sensitive => false }, :format => { :with => SERVER_NAME_REGEX }
  
  validate :must_have_a_valid_list_of_server_aliases,
           :must_have_a_unencrypted_ssl_key,
           :must_have_a_well_formatted_ssl_ca_certificate,
           :must_have_a_well_formatted_ssl_certificate,
           :must_have_a_well_formatted_ssl_key,
           :private_key_must_match_ssl_certificate
  
  def save 
    push_to_amqp if super
  end
  
  protected
  
  def must_have_a_valid_list_of_server_aliases
    return unless server_aliases
  
    server_aliases.split(',').each do |server_alias|
      errors[:server_aliases] = 'is invalid' unless server_alias =~ SERVER_NAME_REGEX
    end
  end
  
  def must_have_a_well_formatted_ssl_ca_certificate
    OpenSSL::X509::Certificate.new(ssl_ca_certificate)
  rescue
    errors[:ssl_ca_certificate] << 'is invalid'
  end
  
  def must_have_a_well_formatted_ssl_certificate
    OpenSSL::X509::Certificate.new(ssl_certificate)
  rescue
    errors[:ssl_certificate] << 'is invalid'
  end
  
  def must_have_a_unencrypted_ssl_key
    errors[:ssl_key] << 'must be unencrypted' if ssl_key =~ /Proc-Type: 4,ENCRYPTED/
  end
  
  def must_have_a_well_formatted_ssl_key
    OpenSSL::PKey::RSA.new(ssl_key) if errors[:ssl_key].empty?
  rescue
    errors[:ssl_key] << 'is invalid'
  end
  
  def private_key_must_match_ssl_certificate
    if errors.empty?
      pkey_modulo = OpenSSL::PKey::RSA.new(ssl_key).to_text.match(/modulus:((\s*([a-z0-9][a-z0-9]:)+(([a-z0-9][a-z0-9]:)|([a-z0-9][a-z0-9])))*)/i)[1].gsub(/[\n\s]/, '')
      cert_modulo = OpenSSL::X509::Certificate.new(ssl_certificate).to_text.match(/modulus:((\s*([a-z0-9][a-z0-9]:)+(([a-z0-9][a-z0-9]:)|([a-z0-9][a-z0-9])))*)/i)[1].gsub(/[\n\s]/, '')
      errors[:ssl_key] = 'must match the ssl certificate' unless pkey_modulo == cert_modulo
    end
  end
  
  def push_to_amqp
    
    AMQP.start(APP_CONFIG['amqp']) do |connection|
      channel = AMQP::Channel.new(connection)
      exchange = channel.fanout(APP_CONFIG['amqp_channel'])
      
      exchange.publish(attributes.to_json, :persistent => true) do
        connection.close { EventMachine.stop }
      end
    end
    
    return true
    
  rescue
    errors[:amqp_connection] << 'cannot be established'
    return false
  end
  
end

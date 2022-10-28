require 'openssl'
require 'pp'

##
# This class is to initialize with a SSL certificate, an unencrypted ssl key and
# a optional ca certificate.
#
# e.g.:
#
# vhost = VHost.new({:ssl_certificate => 'cert content', :ssl_key => key, :ssl_ca_certificate => 'ca cert'})
#
# The push_to_amqp instance method will perform some validations on the passed certificate and
# SSL key and eventually it will push the information to an amqp fanout-exchange. One ore more
# Worker can connect (subscribe) to the amqp exchange and make webserver config changes to make
# the ssl certificate working.
#
class VHost < ActiveRecord::Base
  
  # SERVER_NAME_REGEX = /^(\*\.)?([a-zA-Z0-9]([a-zA-Z0-9\-])*[a-zA-Z0-9]\.)*([A-Za-z0-9]([A-Za-z0-9\-])*[A-Za-z0-9])\.([A-Za-z0-9]([A-Za-z0-9\-])*[A-Za-z0-9])$/
  # validates :server_name, :uniqueness => { :case_sensitive => false }, :format => { :with => SERVER_NAME_REGEX, :multiline => true}
  
  SERVER_NAME_REGEX = /\A(\*\.)?([a-zA-Z0-9]([a-zA-Z0-9\-])*[a-zA-Z0-9]\.)*([A-Za-z0-9]([A-Za-z0-9\-])*[A-Za-z0-9])\.([A-Za-z0-9]([A-Za-z0-9\-])*[A-Za-z0-9])\z/

  validates :server_name, :uniqueness => { :case_sensitive => false }, :format => { :with => SERVER_NAME_REGEX }

  validate :must_have_a_valid_list_of_server_aliases,
           :must_have_a_unencrypted_ssl_key,
           :must_have_a_well_formatted_ssl_ca_certificate,
           :must_have_a_well_formatted_ssl_certificate,
           :must_have_a_well_formatted_ssl_key,
           :private_key_must_match_ssl_certificate
  
  def save
    if valid?
      push_to_amqp
      super
    end
  end
  
  def destroy
    push_destroy_to_amqp
    super
  end

  def server_name

    if super.blank?
      self.server_name = server_name_from_ssl_certificate
    end

    return super
  end

  def server_aliases
    if super.blank?
      self.server_aliases = server_aliases_from_ssl_certificate
    end

    return super
  end
  
  protected
  
  def must_have_a_valid_list_of_server_aliases
    return unless server_aliases
  
    server_aliases.split(',').each do |server_alias|
      errors[:server_aliases] << 'is invalid' unless server_alias =~ SERVER_NAME_REGEX
    end
  end
  
  def must_have_a_well_formatted_ssl_ca_certificate
    
    # The ca certificate is optional
    return if ssl_ca_certificate.blank?     

    OpenSSL::X509::Certificate.new(ssl_ca_certificate)

    #the certificate should start with "-----BEGIN CERTIFICATE-----"
    #and end with "-----END CERTIFICATE-----"
    tmp_cert = ssl_ca_certificate.gsub("\n", "")
    raise unless tmp_cert.strip =~ /^-+BEGIN CERTIFICATE(.*)END CERTIFICATE-+$/
  rescue
    errors[:ssl_ca_certificate] << 'is invalid'
  end
  
  def must_have_a_well_formatted_ssl_certificate
    OpenSSL::X509::Certificate.new(ssl_certificate)

    #the certificate should start with "-----BEGIN CERTIFICATE-----"
    #and end with "-----END CERTIFICATE-----"
    tmp_cert = ssl_certificate.gsub("\n", "")
    raise unless tmp_cert.strip =~ /^-+BEGIN CERTIFICATE(.*)END CERTIFICATE-+$/
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
      pkey_modulo = OpenSSL::PKey::RSA.new(ssl_key).to_text.match(/modulus.*:((\s*([a-z0-9][a-z0-9]:)+(([a-z0-9][a-z0-9]:)|([a-z0-9][a-z0-9])))*)/i)[1].gsub(/[\n\s]/, '')
      cert_modulo = OpenSSL::X509::Certificate.new(ssl_certificate).to_text.match(/modulus.*:((\s*([a-z0-9][a-z0-9]:)+(([a-z0-9][a-z0-9]:)|([a-z0-9][a-z0-9])))*)/i)[1].gsub(/[\n\s]/, '')

      errors[:ssl_key] << 'must match the ssl certificate' unless pkey_modulo == cert_modulo
    end
  end

  def server_name_from_ssl_certificate
    OpenSSL::X509::Certificate.new(ssl_certificate).to_text.match(/^\s*Subject\: .*CN=(.*)/)[1].split('/').first
  rescue OpenSSL::X509::CertificateError
    nil
  end

  def server_aliases_from_ssl_certificate
    results = dns_alt_names_from_ssl_certificate.delete_if { |x| x.downcase == self.server_name.downcase }
    return nil if results.empty?
    results * ','
  end

  def dns_alt_names_from_ssl_certificate
    subject_alt_names = OpenSSL::X509::Certificate.new(ssl_certificate).extensions.detect { |x| x.to_s =~ /.*subjectAltName.*/ }  
    subject_alt_names.value.split(",").map { |x| x.strip }.select { |x| x =~ /^DNS\:/ }.map { |x| x[4..-1] }
  rescue
    []
  end
  
  # triggers a deletion of a vhost 
  def push_destroy_to_amqp
    AMQP.start(APP_CONFIG['amqp']) do |connection|
      channel = AMQP::Channel.new(connection)
      exchange = channel.fanout(APP_CONFIG['amqp_channel'], :durable => true)
      
      payload = {
        :action => 'delete',
        :server_name => server_name
      }
      
      exchange.publish(payload.to_json, :persistent => true) do
        connection.close { EventMachine.stop }
      end
    end
    
    return true
  end
  
  # push a create vhost with a ssl cert to the amqp (rabbitmq)
  def push_to_amqp

    AMQP.start(APP_CONFIG['amqp']) do |connection|

      channel = AMQP::Channel.new(connection)

      channel.on_connection_interruption do |ch|
        puts "--> Channel #{ch.id} detected connection interruption"
        EventMachine.stop
      end

      exchange = channel.fanout(APP_CONFIG['amqp_channel'], :durable => true)
      exchange.on_connection_interruption do |ex|
        puts "--> Exchange #{ex.name} detected connection interruption"
        EventMachine.stop
      end 

      exchange.publish(attributes.to_json.gsub('\r\n', '\n'), :persistent => true) do
        connection.close { EventMachine.stop }
      end
    end

    return true
  end
  
end

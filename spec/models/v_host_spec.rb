require 'spec_helper'

describe VHost do
  describe '#create' do
    context 'with valid attributes for a v host' do
      it 'saves a valid vhost' do
        vhost = FactoryBot.build(:valid_v_host)
        expect(vhost.save).to be true
        expect(vhost.errors).to be_empty
      end

      it 'saves a valid ECC vhost' do
        vhost = FactoryBot.build(:ec_valid_v_host)
        expect(vhost.save).to be true
        expect(vhost.errors).to be_empty
      end

      it 'encrypts valid vhosts ssl attributes' do
        vhost = FactoryBot.build(:valid_v_host)
        expect(vhost.save).to be true
        expect(vhost.encrypted_attribute?(:ssl_certificate)).to be true
        expect(vhost.encrypted_attribute?(:ssl_ca_certificate)).to be true
        expect(vhost.encrypted_attribute?(:ssl_key)).to be true
      end

      it 'encrypts valid ECC vhosts ssl attributes' do
        vhost = FactoryBot.build(:ec_valid_v_host)
        expect(vhost.save).to be true
        expect(vhost.encrypted_attribute?(:ssl_certificate)).to be true
        expect(vhost.encrypted_attribute?(:ssl_ca_certificate)).to be true
        expect(vhost.encrypted_attribute?(:ssl_key)).to be true
      end

      it 'pushes a valid vhost to RabbitMQ' do
        # pending
      end

      it 'does not save the private ssl key to the local db' do
        # pending
      end

      it 'pushes the private ssl key to RabbitMQ' do
        # pending
      end
    end

    context 'with a blank ssl ca certificate' do
      it 'does not save' do
        vhost = FactoryBot.build(:valid_v_host_without_ca_cert)
        vhost.save
        expect(vhost.errors[:ssl_ca_certificate].first).to eq 'is invalid'
      end

      it 'does not save ECC vhost' do
        vhost = FactoryBot.build(:ec_valid_v_host_without_ca_cert)
        vhost.save
        expect(vhost.errors[:ssl_ca_certificate].first).to eq 'is invalid'
      end
    end

    context 'with any invalid attribute' do
      it 'does not push data to the RabbitMQ' do
        vhost = FactoryBot.build(:v_host_with_invalid_ssl_key)
        vhost.expects(:push_to_amqp).never
        vhost.save
      end

      it 'does not push EC data to the RabbitMQ' do
        vhost = FactoryBot.build(:ec_v_host_with_invalid_ssl_key)
        vhost.expects(:push_to_amqp).never
        vhost.save
      end
    end

    context 'with an broken RabbitMQ connection and valid attributes' do
      it 'does not save the vhost to the database' do
        vhost = FactoryBot.build(:valid_v_host)
        vhost.stubs(:push_to_amqp).raises AMQP::TCPConnectionFailed

        begin
          vhost.save
        rescue StandardError
          expect(VHost.all.count).to be 0
        end
      end
    end

    context 'with an encrypted ssl key' do
      it 'triggers an error' do
        vhost = FactoryBot.build(:v_host_with_encrypted_ssl_key)
        vhost.save

        expect(vhost.errors[:ssl_key].first).to eq 'must be unencrypted'
      end

      it 'triggers an error for ECC' do
        vhost = FactoryBot.build(:ec_v_host_with_encrypted_ssl_key)
        vhost.save

        expect(vhost.errors[:ssl_key].first).to eq 'must be unencrypted'
      end
    end

    context 'with an invalid ssl key' do
      it 'triggers an error' do
        vhost = FactoryBot.build(:v_host_with_invalid_ssl_key)
        vhost.save
        expect(vhost.errors[:ssl_key].first).to eq 'is invalid'
      end

      it 'triggers an error for ECC' do
        vhost = FactoryBot.build(:ec_v_host_with_invalid_ssl_key)
        vhost.save
        expect(vhost.errors[:ssl_key].first).to eq 'is invalid'
      end
    end

    context 'with an invalid ssl certificate' do
      it 'triggers an error' do
        vhost = FactoryBot.build(:v_host_with_invalid_ssl_certificate)
        vhost.save
        expect(vhost.errors[:ssl_certificate].first).to eq 'is invalid'
      end

      it 'triggers an error for ECC' do
        vhost = FactoryBot.build(:ec_v_host_with_invalid_ssl_certificate)
        vhost.save
        expect(vhost.errors[:ssl_certificate].first).to eq 'is invalid'
      end
    end

    context 'with an ssl certificate containing useless appending' do
      it 'triggers an error' do
        vhost = FactoryBot.build(:v_host_with_ssl_certificate_containing_usless_appending)

        vhost.save
        expect(vhost.errors[:ssl_certificate].first).to eq 'is invalid'
      end

      it 'triggers an error for ECC' do
        vhost = FactoryBot.build(:ec_v_host_with_ssl_certificate_containing_usless_appending)

        vhost.save
        expect(vhost.errors[:ssl_certificate].first).to eq 'is invalid'
      end
    end

    context 'with an invalid ssl ca certificate' do
      it 'triggers an error' do
        vhost = FactoryBot.build(:v_host_with_invalid_ssl_ca_certificate)
        vhost.save
        expect(vhost.errors[:ssl_ca_certificate].first).to eq 'is invalid'
      end

      it 'triggers an error for ECC' do
        vhost = FactoryBot.build(:ec_v_host_with_invalid_ssl_ca_certificate)
        vhost.save
        expect(vhost.errors[:ssl_ca_certificate].first).to eq 'is invalid'
      end
    end

    context 'with a different modulo in the ssl certificate and the ssl key' do
      it 'triggers an error' do
        vhost = FactoryBot.build(:v_host_with_corrupt_ssl_certificate)
        vhost.save
        expect(vhost.errors[:ssl_key].first).to eq 'must match the ssl certificate'
      end
    end

    context 'with an already existing server name' do
      it 'triggers an error' do
        vhost = FactoryBot.create(:valid_v_host)
        vhost.server_name.capitalize!
        vhost.save

        other_vhost = FactoryBot.build(:valid_v_host)
        other_vhost.save
        expect(other_vhost.errors[:server_name].first).to eq 'has already been taken'
      end

      it 'triggers an error for ECC' do
        vhost = FactoryBot.create(:ec_valid_v_host)
        vhost.server_name.capitalize!
        vhost.save

        other_vhost = FactoryBot.build(:valid_v_host)
        other_vhost.save
        expect(other_vhost.errors[:server_name].first).to eq 'has already been taken'
      end
    end

    context 'with an invalid host name' do
      it 'detects that "host" is a invalid host name' do
        vhost = FactoryBot.build(:valid_v_host, server_name: 'host')
        vhost.save
        expect(vhost.errors[:server_name].first).to eq 'is invalid'
      end

      it 'detects that "host" is a invalid host name for ECC' do
        vhost = FactoryBot.build(:ec_valid_v_host, server_name: 'host')
        vhost.save
        expect(vhost.errors[:server_name].first).to eq 'is invalid'
      end

      it 'detects that "host.4" is a invalid host name' do
        vhost = FactoryBot.build(:valid_v_host, server_name: 'host.4')
        vhost.save
        expect(vhost.errors[:server_name].first).to eq 'is invalid'
      end

      it 'detects that "host.4" is a invalid host name for ECC' do
        vhost = FactoryBot.build(:ec_valid_v_host, server_name: 'host.4')
        vhost.save
        expect(vhost.errors[:server_name].first).to eq 'is invalid'
      end

      it 'detects that "-host" is a invalid host name' do
        vhost = FactoryBot.build(:valid_v_host, server_name: 'host.4')
        vhost.save
        expect(vhost.errors[:server_name].first).to eq 'is invalid'
      end

      it 'detects that "-host" is a invalid host name for ECC' do
        vhost = FactoryBot.build(:ec_valid_v_host, server_name: 'host.4')
        vhost.save
        expect(vhost.errors[:server_name].first).to eq 'is invalid'
      end
    end

    context 'with not specified server name' do
      context 'with a wildcard certificate' do
        it 'sets the server name from the certificate' do
          vhost = FactoryBot.build(:v_host_with_wildcard_certificate)
          expect(vhost.server_name).to eq '*.railshoster.de'
        end

        it 'sets a server alias to the host without a wildcard' do
          vhost = FactoryBot.build(:v_host_with_wildcard_certificate)
          expect(vhost.server_aliases).to eq 'railshoster.de'
        end
      end

      context 'with a simple certificate (one subject alt name)' do
        it 'detects the server name from the certificate' do
          vhost = FactoryBot.build(:v_host_with_one_subject_alt_name)
          expect(vhost.server_name).to eq 'mail.kundenportal.railshoster.de'
        end
      end

      context 'with a www certificate' do
        it 'detects the server name from the certificate' do
          vhost = FactoryBot.build(:v_host_with_www_alt_name)
          expect(vhost.server_name).to eq 'www.fancyerp.com'
        end

        it 'sets a server alias to the host without www prefix' do
          vhost = FactoryBot.build(:v_host_with_www_alt_name)
          expect(vhost.server_aliases).to eq 'fancyerp.com'
        end
      end
    end

    context 'with valid server aliases' do
      it 'saves the aliases' do
        vhost = FactoryBot.build(:valid_v_host, server_aliases: 'alias.de,alias.com,alias.org')
        expect(vhost.save).to be true
        expect(vhost.errors).to be_empty
      end

      it 'saves the aliases for ECC' do
        vhost = FactoryBot.build(:ec_valid_v_host, server_aliases: 'alias.de,alias.com,alias.org')
        expect(vhost.save).to be true
        expect(vhost.errors).to be_empty
      end

      it 'saves the alias' do
        vhost = FactoryBot.build(:valid_v_host, server_aliases: 'alias.de')
        expect(vhost.save).to be true
        expect(vhost.errors).to be_empty
      end

      it 'saves the alias for ECC' do
        vhost = FactoryBot.build(:ec_valid_v_host, server_aliases: 'alias.de')
        expect(vhost.save).to be true
        expect(vhost.errors).to be_empty
      end
    end

    context 'with invalid server aliases' do
      it 'detects that "alias.de,a" is a invalid server aliases list' do
        vhost = FactoryBot.build(:valid_v_host, server_aliases: 'alias.de,a')
        vhost.save
        expect(vhost.errors[:server_aliases].first).to eq 'is invalid'
      end

      it 'detects that "alias.de,a" is a invalid server aliases list for ECC' do
        vhost = FactoryBot.build(:ec_valid_v_host, server_aliases: 'alias.de,a')
        vhost.save
        expect(vhost.errors[:server_aliases].first).to eq 'is invalid'
      end

      it 'detects that "alias.de, " is a invalid server aliases list' do
        vhost = FactoryBot.build(:valid_v_host, server_aliases: 'alias.de, ')
        vhost.save
        expect(vhost.errors[:server_aliases].first).to eq 'is invalid'
      end

      it 'detects that "alias.de, " is a invalid server aliases list for ECC' do
        vhost = FactoryBot.build(:ec_valid_v_host, server_aliases: 'alias.de, ')
        vhost.save
        expect(vhost.errors[:server_aliases].first).to eq 'is invalid'
      end

      it 'detects that "alias.de alias.com" is a invalid server aliases list' do
        vhost = FactoryBot.build(:valid_v_host, server_aliases: 'alias.de alias.com')
        vhost.save
        expect(vhost.errors[:server_aliases].first).to eq 'is invalid'
      end

      it 'detects that "alias.de alias.com" is a invalid server aliases list for ECC' do
        vhost = FactoryBot.build(:ec_valid_v_host, server_aliases: 'alias.de alias.com')
        vhost.save
        expect(vhost.errors[:server_aliases].first).to eq 'is invalid'
      end
    end
  end

  describe '#destroy' do
    context 'with a existing virtual host' do
      it 'deletes the virtual host from the database' do
        vhost = FactoryBot.build(:valid_v_host)
        vhost.save
        vhost.destroy
        expect(VHost.all.count).to be 0
      end

      it 'deletes the ECC virtual host from the database' do
        vhost = FactoryBot.build(:ec_valid_v_host)
        vhost.save
        vhost.destroy
        expect(VHost.all.count).to be 0
      end

      it 'pushes the delete command to amqp' do
        vhost = FactoryBot.build(:valid_v_host)
        vhost.expects(:push_destroy_to_amqp)
        vhost.destroy
      end

      it 'pushes the delete command to amqp for ECC' do
        vhost = FactoryBot.build(:ec_valid_v_host)
        vhost.expects(:push_destroy_to_amqp)
        vhost.destroy
      end
    end
  end
end

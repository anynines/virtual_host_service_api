require 'spec_helper'

describe VHost do
  
  describe '#create' do
    
    context 'with valid attributes for a v host' do 
      it 'should save a valid vhost' do
        vhost = FactoryGirl.build(:valid_v_host)
        vhost.save.should be true
        vhost.errors.should be_empty
      end
      
      it 'should push a valid vhost to rebbitMQ' do
        pending
      end
      
      it 'should not save the private ssl key to the local db' do
        pending
      end
      
      it 'should push the private ssl key to rebbitMQ' do
        pending
      end
      
    end
    
    context 'with an encrypted ssl key' do
      it 'should trigger an error' do
        vhost = FactoryGirl.build(:v_host_with_encrypted_ssl_key)
        vhost.save
        vhost.errors[:ssl_key].first.should eq 'must be unencrypted'
      end
    end
    
    context 'with an invalid ssl key' do
      it 'should trigger an error' do
        vhost = FactoryGirl.build(:v_host_with_invalid_ssl_key)
        vhost.save
        vhost.errors[:ssl_key].first.should eq 'is invalid'
      end
    end
    
    context 'with an invalid ssl certificate' do
      it 'should trigger an error' do
        vhost = FactoryGirl.build(:v_host_with_invalid_ssl_certificate)
        vhost.save
        vhost.errors[:ssl_certificate].first.should eq 'is invalid'
      end
    end
    
    context 'with an invalid ssl ca certificate' do
      it 'it should trigger an error' do
        vhost = FactoryGirl.build(:v_host_with_invalid_ssl_ca_certificate)
        vhost.save
        vhost.errors[:ssl_ca_certificate].first.should eq 'is invalid'
      end
    end
    
    context 'with a different modulo in the ssl certificate and the ssl key' do
      it 'should trigger an error' do
        vhost = FactoryGirl.build(:v_host_with_corrupt_ssl_certificate)
        vhost.save
        vhost.errors[:ssl_key].first.should eq 'must match the ssl certificate'
      end
    end
    
    context 'with an already existing server name' do
      it 'should trigger an error' do
        vhost = FactoryGirl.create(:valid_v_host)
        vhost.server_name.capitalize!
        vhost.save
        
        other_vhost = FactoryGirl.build(:valid_v_host)
        other_vhost.save
        other_vhost.errors[:server_name].first.should eq 'has already been taken'
      end
    end
    
    context 'with an invalid host name' do
      it 'should detect that "host" is a invalid host name' do
        vhost = FactoryGirl.build(:valid_v_host, :server_name => "host")
        vhost.save
        vhost.errors[:server_name].first.should eq 'is invalid'
      end
      
      it 'should detect that "host.4" is a invalid host name' do
        vhost = FactoryGirl.build(:valid_v_host, :server_name => "host.4")
        vhost.save
        vhost.errors[:server_name].first.should eq 'is invalid'
      end
      
      it 'should detect that "-host" is a invalid host name' do
        vhost = FactoryGirl.build(:valid_v_host, :server_name => "host.4")
        vhost.save
        vhost.errors[:server_name].first.should eq 'is invalid'
      end
    end
    
    context 'with valid server aliases' do
      it 'should save the aliases' do
        vhost = FactoryGirl.build(:valid_v_host, :server_aliases => "alias.de,alias.com,alias.org")
        vhost.save.should be true
        vhost.errors.should be_empty
      end
      
      it 'should save the alias' do
        vhost = FactoryGirl.build(:valid_v_host, :server_aliases => "alias.de")
        vhost.save.should be true
        vhost.errors.should be_empty
      end
    end
    
    context 'with invalid server aliases' do
      it 'should detect that "alias.de,a" is a invalid server aliases list' do
        vhost = FactoryGirl.build(:valid_v_host, :server_aliases => "alias.de,a")
        vhost.save
        vhost.errors[:server_aliases].first.should eq 'is invalid'
      end
      
      it 'should detect that "alias.de, " is a invalid server aliases list' do
        vhost = FactoryGirl.build(:valid_v_host, :server_aliases => "alias.de, ")
        vhost.save
        vhost.errors[:server_aliases].first.should eq 'is invalid'
      end
      
      it 'should detect that "alias.de alias.com" is a invalid server aliases list' do
        vhost = FactoryGirl.build(:valid_v_host, :server_aliases => "alias.de alias.com")
        vhost.save
        vhost.errors[:server_aliases].first.should eq 'is invalid'
      end
    end
    
  end
    
end
  
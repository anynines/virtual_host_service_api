require 'spec_helper'

describe VHostsController, type: :controller do
  
  let :invalid_api_key do
    'invalid'
  end
  
  let :api_key do
    APP_CONFIG['api_keys'].values.first
  end
  
  describe 'POST create' do
  
    context 'with an invalid api key' do
      
      it 'should respond with a unauthorized http header' do
        post :create, params: { vhost: FactoryBot.attributes_for(:valid_v_host), access_token: invalid_api_key }

        expect(response.response_code).to be 401
      end
      
      it 'should not create a vHost' do
        post :create, params: { vhost: FactoryBot.attributes_for(:valid_v_host), access_token: invalid_api_key }
        
        expect(VHost.all.count).to be 0
      end
      
    end
    
    context 'with a valid api key' do
      context 'with valid params' do
      
        it 'should respond with a ok http header' do
          FactoryBot.attributes_for(:valid_v_host)

          post :create, params: { access_token: api_key, v_host: FactoryBot.attributes_for(:valid_v_host) }

          expect(response.response_code).to eq 200
        end
        
        it 'should save the vHost' do
          attr = FactoryBot.attributes_for(:valid_v_host)
          post :create, params: { v_host: attr, access_token: api_key }

          expect(VHost.first.server_name).to eq attr[:server_name]
        end
        
        it 'should save the vHost and the server aliases' do
          attr = FactoryBot.attributes_for(:valid_v_host, :server_aliases => "alias.de,alias.com,alias.com")
          post :create, params: { v_host: attr, access_token: api_key }
          
          expect(VHost.first.server_aliases).to eq attr[:server_aliases]
        end
      end

      context 'with valid params and broken RabbitMQ connection' do
        it 'should respond with a server error status code' do
          VHost.any_instance.stubs(:push_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))
          post :create, params: { v_host: FactoryBot.attributes_for(:valid_v_host), access_token: api_key }

          expect(response.response_code).to be 500
        end
    
        it 'should respond with a descriptive error message' do
          VHost.any_instance.stubs(:push_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))
          post :create, params: { v_host: FactoryBot.attributes_for(:valid_v_host), access_token: api_key }

          expect(JSON.parse(response.body)['errors']).not_to be :empty
        end
      end
      
      context 'wiht invalid params' do
        it 'should respond with unprocessable entity http header' do
          post :create, params: { v_host: FactoryBot.attributes_for(:v_host_with_invalid_ssl_key), access_token: api_key }

          expect(response.response_code).to be 422
        end
        
        it 'should respond with some descriptive error messages' do
          post :create, params: { v_host: FactoryBot.attributes_for(:v_host_with_invalid_ssl_key), access_token: api_key }
          
          expect(JSON.parse(response.body)['errors']).not_to be :empty
        end
      
      end
      
    end
    
  end
  
  describe 'DELETE destroy_by_server_name' do
    context 'with a valid api key' do
      context 'with an existing vhost and with a working RabbitMQ connection' do
      
        it 'should delete the vhost' do
          vhost = FactoryBot.create(:valid_v_host)
          delete :destroy_by_server_name, params: { access_token: api_key, server_name: vhost.server_name }

          expect(VHost.all.count).to be 0
        end

      end

      context 'with an existing vhost and with a broken RabbitMQ connection' do
      
        it 'should respond with a server error status code' do
          VHost.any_instance.stubs(:push_destroy_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))
          vhost = FactoryBot.create(:valid_v_host)
          delete :destroy_by_server_name, params: { access_token: api_key, server_name: vhost.server_name }

          expect(response.response_code).to be 500
        end
    
        it 'should respond with a descriptive error message' do
          VHost.any_instance.stubs(:push_destroy_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))
          vhost = FactoryBot.create(:valid_v_host)
          delete :destroy_by_server_name, params: { access_token: api_key, server_name: vhost.server_name }

          expect(JSON.parse(response.body)['errors']).not_to be :empty
        end

        it 'should not delete the vhost' do
          VHost.any_instance.stubs(:push_destroy_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))
          vhost = FactoryBot.create(:valid_v_host)
          delete :destroy_by_server_name, params: { access_token: api_key, server_name: vhost.server_name }

          expect(VHost.all.count).to be 1
        end

      end
    end
  end

  describe 'GET by_organization' do
    context 'with a valid api key' do
      context 'with existing v hosts for an organization' do
        
        it 'should list all vhosts from an organization' do
          FactoryBot.create(:valid_v_host, :server_name => "example1.com", :organization_guid => "1")
          FactoryBot.create(:valid_v_host, :server_name => "example2.com", :organization_guid => "1")
          FactoryBot.create(:valid_v_host, :server_name => "example3.com", :organization_guid => "1")
          FactoryBot.create(:valid_v_host, :server_name => "example4.com", :organization_guid => "2")
          FactoryBot.create(:valid_v_host, :server_name => "example5.com", :organization_guid => "2-a-3-2")
          
          get :by_organization, params: { access_token: api_key, guid: "1" }

          expect(JSON.parse(response.body).count).to be 3
        end
      end
    end
  end
  
end
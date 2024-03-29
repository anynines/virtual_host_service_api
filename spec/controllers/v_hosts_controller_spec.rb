require 'spec_helper'

describe VHostsController do
  
  let :invalid_api_key do
    'invalid'
  end
  
  let :api_key do
    'bpiuqrhp9boej3cnoesasekr20'
  end
  
  describe 'POST create' do
  
    context 'with an invalid api key' do
      
      it 'should respond with a unauthorized http header' do
        
        post :create, {
          :v_host => FactoryGirl.attributes_for(:valid_v_host),
          :access_token => invalid_api_key
        }
        
        response.response_code.should be 401
      end
      
      it 'should not create a vHost' do
        
        post :create, {
          :v_host => FactoryGirl.attributes_for(:valid_v_host),
          :access_token => invalid_api_key
        }
        
        VHost.all.count.should be 0
      end
      
    end
    
    context 'with a valid api key' do
      
      context 'with valid params' do
      
        it 'should respond with a ok http header' do
          
          post :create, {
            :v_host => FactoryGirl.attributes_for(:valid_v_host),
            :access_token => api_key
          }
          
          response.response_code.should be 200
        end
        
        it 'should save the vHost' do
          
          attr = FactoryGirl.attributes_for(:valid_v_host)
          
          post :create, {
            :v_host => attr,
            :access_token => api_key
          }
          
          VHost.first.server_name.should eq attr[:server_name]
          
        end
        
        it 'should save the vHost and the server aliases' do
          
          attr = FactoryGirl.attributes_for(:valid_v_host, :server_aliases => "alias.de,alias.com,alias.com")
          
          post :create, {
            :v_host => attr,
            :access_token => api_key
          }
          
          VHost.first.server_aliases.should eq attr[:server_aliases]
          
        end
        
      end

      context 'with valid params and broken RabbitMQ connection' do
        it 'should respond with a server error status code' do

          VHost.any_instance.stubs(:push_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))

          post :create, {
            :v_host => FactoryGirl.attributes_for(:valid_v_host),
            :access_token => api_key
          }

          response.response_code.should be 500
        end
    
        it 'should respond with a descriptive error message' do

          VHost.any_instance.stubs(:push_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))

          post :create, {
            :v_host => FactoryGirl.attributes_for(:valid_v_host),
            :access_token => api_key
          }

          JSON.parse(response.body)['errors'].should_not be :empty
        end
      end
      
      context 'wiht invalid params' do
        
        it 'should respond with unprocessable entity http header' do
          
          post :create, {
            :v_host => FactoryGirl.attributes_for(:v_host_with_invalid_ssl_key),
            :access_token => api_key
          }
          
          response.response_code.should be 422
          
        end
        
        it 'should respond with some descriptive error messages' do
          post :create, {
            :v_host => FactoryGirl.attributes_for(:v_host_with_invalid_ssl_key),
            :access_token => api_key
          }
          
          JSON.parse(response.body)['errors'].should_not be :empty
        end
      
      end
      
    end
    
  end
  
  describe 'DELETE destroy_by_server_name' do
    
    context 'with a valid api key' do
      
      context 'with an existing vhost and with a working RabbitMQ connection' do
      
        it 'should delete the vhost' do
          vhost = FactoryGirl.create(:valid_v_host)
          delete :destroy_by_server_name, {:access_token => api_key, :server_name => vhost.server_name}
          VHost.all.count.should be 0
        end

      end

      context 'with an existing vhost and with a broken RabbitMQ connection' do
      
        it 'should respond with a server error status code' do
          VHost.any_instance.stubs(:push_destroy_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))

          vhost = FactoryGirl.create(:valid_v_host)
          delete :destroy_by_server_name, {:access_token => api_key, :server_name => vhost.server_name}

          response.response_code.should be 500
        end
    
        it 'should respond with a descriptive error message' do
          VHost.any_instance.stubs(:push_destroy_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))

          vhost = FactoryGirl.create(:valid_v_host)
          delete :destroy_by_server_name, {:access_token => api_key, :server_name => vhost.server_name}

          JSON.parse(response.body)['errors'].should_not be :empty
        end

        it 'should not delete the vhost' do
          VHost.any_instance.stubs(:push_destroy_to_amqp).raises(AMQP::TCPConnectionFailed.new({}))

          vhost = FactoryGirl.create(:valid_v_host)
          delete :destroy_by_server_name, {:access_token => api_key, :server_name => vhost.server_name}
          VHost.all.count.should be 1
        end

      end
    end
    
  end

  describe 'GET by_organization' do
    
    context 'with a valid api key' do
      
      context 'with existing v hosts for an organization' do
        
        it 'should list all vhosts from an organization' do
          
          FactoryGirl.create(:valid_v_host, :server_name => "example1.com", :organization_guid => "1")
          FactoryGirl.create(:valid_v_host, :server_name => "example2.com", :organization_guid => "1")
          FactoryGirl.create(:valid_v_host, :server_name => "example3.com", :organization_guid => "1")
          FactoryGirl.create(:valid_v_host, :server_name => "example4.com", :organization_guid => "2")
          FactoryGirl.create(:valid_v_host, :server_name => "example5.com", :organization_guid => "2-a-3-2")
          
          get :by_organization, {:access_token => api_key, :guid => "1"}
          
          JSON.parse(response.body).count.should be 3
          
        end
      
      end
    
    end
    
  end
  
end
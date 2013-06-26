## 
# Every client which wants to perform actions through this api needs a API key
# otherwise every request will rejektet with a 401 status. API keys can be added
# in the application.yml.
class ApiKey

  def initialize(name, access_token)
    @name = name
    @access_token = access_token
  end
  
  def self.find_by_access_token(access_token)
    
    APP_CONFIG['api_keys'].each do |k,v|
      return ApiKey.new(k, v) if access_token == v
    end
    
    return nil
    
  end
end

class ApplicationController < ActionController::API
  
  before_filter :authorize!
  
  protected
  
  ##
  # Every Request needs an access token wich authorizes to use the api.
  # No action will be performed if no access token is specified in the request params.
  def authorize!
    api_key = ApiKey.find_by_access_token(params[:access_token])
    head :unauthorized unless api_key
    return false
  end
end
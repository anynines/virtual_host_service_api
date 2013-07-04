class VHostsController < ApplicationController
  
  def create
    
    vhost = VHost.new(params['v_host'])
    
    if vhost.save
      render :json => vhost
    else
      render :json => {:errors => vhost.errors.full_messages}, :status => 422
    end
    
  end
  
  def destroy_by_server_name
    
    vhost = VHost.where(:server_name => params['server_name']).first
    
    if vhost.destroy
      render :json => 'ok'
    else
      render :json => {:errors => 'error on deleting vhost'}, :status => 422
    end
    
  end
  
  def by_organization
    render :json => VHost.where(:organization_guid => params['guid'])
  end
  
end
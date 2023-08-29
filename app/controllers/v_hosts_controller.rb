class VHostsController < ApplicationController

  def create
    vhost = VHost.new(vhost_params)
    if vhost.save
      render :json => vhost
    else
      render :json => {:errors => vhost.errors.full_messages}, :status => 422
    end

  rescue AMQP::TCPConnectionFailed => ex
    render :json => {:errors => ['Could not establish TCP connection to the amqp broker']}, :status => 500
  end

  def destroy_by_server_name

    vhost = VHost.where(:server_name => params['server_name']).first

    if vhost.destroy
      render :json => 'ok'
    else
      render :json => {:errors => 'error on deleting vhost'}, :status => 422
    end

  rescue AMQP::TCPConnectionFailed => ex
    render :json => {:errors => ['Could not establish TCP connection to the amqp broker']}, :status => 500
  end

  def by_organization
    render :json => VHost.where(:organization_guid => params['guid'])
  end

  private

  def vhost_params
    params.require(:v_host).permit(:organization_guid, :server_name, :ssl_ca_certificate, :ssl_certificate, :ssl_key, :server_aliases)
  end
  
end

VirtualHostService::Application.routes.draw do

  resources :v_hosts, :only => [:create] do
    collection do
      get 'by_organization'
    end
  end
  
end

Rails.application.routes.draw do

  resources :v_hosts, :only => [:create] do
    collection do
      get 'by_organization'
      delete 'destroy_by_server_name'
    end
  end
end

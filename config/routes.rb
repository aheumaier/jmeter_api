Site::Application.routes.draw do

  resources :log_definition_files

  resources :jmx_definition_files

  match 'projects/:project_id/jmeter_runs/current'  => 'jmeter_runs#current'
  resources :projects do
    resources :jmeter_runs do 
      member do
        get 'status'
        get 'start'
        get 'kill'
      end
    end
    resources :settings do 
    end           
  end

  get "dashboard/index"

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'dashboard#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

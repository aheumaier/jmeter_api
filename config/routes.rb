Site::Application.routes.draw do

  namespace :api do # JSON REST ::API
    namespace :v1 do
      match 'projects/:project_id/jmeter_runs/current'  => 'jmeter_runs#current'
      match 'projects/exists'  => 'projects#exists'
      resources :projects do
        resources :jmeter_runs do
          member do
            get 'status'
            get 'start'
            get 'kill'
            get 'repeat'
          end
          #resources :log_definition_files
          #resources :jmx_definition_files
        end
        #resources :jmeter_settings
      end
    end
    match 'v:api/*path', :to => redirect("/api/v1/%{path}")
    match '*path', :to => redirect("/api/v1/%{path}")
  end

  match 'projects/:project_id/jmeter_runs/current'  => 'jmeter_runs#current'

  resources :projects do
    resources :jmeter_runs do
      member do
        get 'status'
        get 'start'
        get 'kill'
        get 'repeat'
      end
    end
  end

  match 'jmx_definition_files/:id/set_as_default'  => 'jmx_definition_files#set_as_default'

  resources :log_definition_files
  resources :jmx_definition_files
  get "dashboard/clear_queue"
  get "definition_files/index"
  get "dashboard/index"
  root :to => 'dashboard#index'

end

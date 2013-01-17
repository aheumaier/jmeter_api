Site::Application.routes.draw do
  get "versuch_class/index"

  get "versuch_class/show"

  get "definition_files/index"

  namespace :api do # JSON REST ::API
    namespace :v1 do
      match 'projects/:project_id/jmeter_runs/current'  => 'jmeter_runs#current'
      resources :projects do
        resources :jmeter_runs do
          member do
            get 'status'
            get 'start'
            get 'kill'
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
  end

  get "dashboard/index"
  root :to => 'dashboard#index'

end

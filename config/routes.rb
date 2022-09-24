Rails.application.routes.draw do
  defaults format: :json do
    get '/healthz', to: proc { [200, {}, ['success']] }
    namespace :api do
      namespace :v1 do
        resources :bed_sensor, only: [:index, :show, :update]
      end
    end
  end
end

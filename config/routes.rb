Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # these names spaces add the paths, aka, 'api/v1'
  namespace :api do
    namespace :v1 do
      #we get musify/login to login controller, spotify auth action
      get '/login', to: 'login#spotify_auth'
    end 
  end
end

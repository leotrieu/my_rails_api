Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/list', to: 'items#list'
      get '/search', to: 'items#search'
    end
  end 
end

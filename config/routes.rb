Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root "welcome#index"
   get "/user/login", to: 'users#login'
   get "/user/stufftosell", to: 'users#stufftosell'
   get "/user/requests", to: 'users#requests'
   post "sessions", to: "sessions#create"
   delete "sessions", to: "sessions#destroy"
   resources :requests
   resources :books do
      get 'search', on: :collection
   end

   resources :items do
      get 'search', on: :collection
   end

end

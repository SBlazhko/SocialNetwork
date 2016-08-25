Rails.application.routes.draw do
  
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
      controller :profiles do
        get "profiles", to: "profiles#index"
        post "profiles", to: "profiles#create"
        get "profile", to: "profiles#show"
        put "profile", to: "profiles#update"
        delete "profile", to: "profiles#destroy"
      end

      controller :posts do
        get "profile/posts", to: 'posts#index'
        post "profile/posts", to: 'posts#create'
        get "profile/post", to: 'posts#show'
        put "profile/post", to: 'posts#update'
        delete "profile/post", to: 'posts#destroy'
      end

      controller :tokens do
    		post "login", to: "tokens#login"
    		post "logout", to: "tokens#logout"
      end

    end
	end
end

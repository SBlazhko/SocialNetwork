Rails.application.routes.draw do
  
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
     
      resource :profile, except: [:new, :edit] do
        resource :post, except: [:new, :edit]
      end

      get 'profiles', to: "profiles#index"
      get 'profile/posts', to: "posts#index"

      controller :tokens do
    		post "login", to: "tokens#login"
    		post "logout", to: "tokens#logout"
      end

    end
	end
end

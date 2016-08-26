Rails.application.routes.draw do
  
  apipie

  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
<<<<<<< HEAD
  		resources :profiles, only: [:index, :create, :show, :update, :destroy] do
  			resources :posts
  		end
  		post "tokens/login", to: "tokens#login"
  		post "tokens/logout", to: "tokens#logout"
      post "/upload_file", to: 'attachment_file#upload_file'
=======
     
      resource :profile, except: [:new, :edit] do
        resource :post, except: [:new, :edit]
      end

      get 'profiles', to: "profiles#index"
      get 'profile/posts', to: "posts#index"

      controller :tokens do
    		post "login", to: "tokens#login"
    		post "logout", to: "tokens#logout"
      end

      controller :user_infos do
        get 'profile/info/' => :show
        post 'profile/info/' => :create
        put 'profile/info/' => :update
        delete 'profile/info/' => :destroy
      end
    end
>>>>>>> 9b25f81186b5b173b490a345d2478499dfee3b10
	end
end

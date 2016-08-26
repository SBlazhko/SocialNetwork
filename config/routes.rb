Rails.application.routes.draw do
  
  apipie

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

      controller :user_infos do
        get 'profile/info/' => :show
        post 'profile/info/' => :create
        put 'profile/info/' => :update
        delete 'profile/info/' => :destroy
      end

      controller :messages do
        get 'profile/messages/' => :index
        post 'profile/message/' => :create
        delete 'profile/message/' => :destroy
      end
    end
	end
end

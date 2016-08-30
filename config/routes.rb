Rails.application.routes.draw do
  apipie

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
  		# resources :profiles, only: [:index, :create, :show, :update, :destroy] do
  		# 	resources :posts
  		# end
      post "/upload_file", to: 'attachment_file#upload_file'


      resource :profile, except: [:new, :edit] do
        resource :post, except: [:new, :edit]
      end

      get 'profiles', to: "profiles#index"
      get 'profile/posts', to: "posts#index"
      get 'my_profile', to: "profiles#my_profile"

      controller :tokens do
    		post "login", to: "tokens#login"
    		post "logout", to: "tokens#logout"
      end

      controller :user_infos do
        get 'profile/info/' => :index
        post 'profile/info/' => :create
        put 'profile/info/' => :update
        delete 'profile/info/' => :destroy
      end

      controller :messages do
        get 'profile/messages/' => :index
        post 'profile/message/' => :create
        delete 'profile/message/' => :destroy
      end

      get '/get_files_list/', to: 'attachment_file#get_files_list'
      delete '/destroy_file', to: 'attachment_file#destroy_file'
      get '/get_file', to: 'attachment_file#get_file'

    end
	end
end

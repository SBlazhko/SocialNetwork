Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
  		resources :profiles, only: [:index, :create, :show, :update, :destroy] do
  			resources :posts
  		end
  		post "tokens/login", to: "tokens#login"
  		post "tokens/logout", to: "tokens#logout"
      post "/upload_file", to: 'attachment_file#upload_file'
      get '/get_files_list/', to: 'attachment_file#get_files_list'
      delete '/destroy_file', to: 'attachment_file#destroy_file'
      get '/get_file', to: 'attachment_file#get_file'
	end
  end
end

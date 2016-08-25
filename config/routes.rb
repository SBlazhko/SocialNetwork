Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
  		resources :profiles, only: [:index, :create, :show, :update, :destroy] do
  			resources :posts
  		end
  		post "tokens/login", to: "tokens#login"
  		post "tokens/logout", to: "tokens#logout"
	end
  end
end

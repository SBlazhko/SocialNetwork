Rails.application.routes.draw do
  
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
      controller :profiles do
        get "profiles" => :index
        post "profiles" => :create
        get "profile" => :show
        put "profile" => :update
        delete "profile" => :destroy
  		end

      controller :tokens do
    		post "login" => :login
    		post "logout" => :logout
      end
    end
	end
end

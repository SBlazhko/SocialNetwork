Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :profile
      controller :user_infos do
        get 'info' => :show
        post 'info/add' => :create
        put 'info/edit' => :update
        delete 'info/remove' => :destroy
      end
    end
  end
end

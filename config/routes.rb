Rails.application.routes.draw do
  resources :profiles do
  	member do
      
  		get :toggle_status
  		get :toggle_activity
  		get :toggle_work
  	end
  end
  devise_for :users
  resources :users



  root to: 'users#home'
end

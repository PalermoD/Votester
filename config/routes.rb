Rails.application.routes.draw do
  root 'static_pages#home'
  get 'home' => 'users#new' 
  
  resources :users
 
end

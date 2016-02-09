Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get 'home' => 'users#new' 
  get 'home' => 'sessions#new'
  post 'home' => 'sessions#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  resources :users
  resources :posts 
 
end

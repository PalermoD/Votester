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
  
  resources :posts do 
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
  end
  
end

Rails.application.routes.draw do
mount Commontator::Engine => '/commontator'

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
    resources :comments 
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
  end
  
  resources :comments
end

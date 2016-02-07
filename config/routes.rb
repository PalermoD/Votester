Rails.application.routes.draw do
  root 'static_pages#home'
  get 'home' => 'user#new' 
 
end

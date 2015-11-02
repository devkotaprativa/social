Rails.application.routes.draw do
 
  devise_for :users

  resource :socials
  root 'socials#index'
end

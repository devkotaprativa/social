Rails.application.routes.draw do
 
  devise_for :users

  resource :socials

  devise_scope :user do
    authenticated :user do
      root :to => 'socials#index'
    end
    unauthenticated :user do
      root :to => 'socials#homepage', as: :unauthenticated_root
    end
  end
end

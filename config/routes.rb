Rails.application.routes.draw do
 
  get 'tweets/create'

  get 'tweets/new'

  devise_for :users

  resource :socials
  get '/twitter_profile' => "socials#twitter_profile"
  get '/oauth_account' => "socials#oauth_account"
  get '/twitter_oauth_url' => 'socials#generate_twitter_oauth_url'

  resource :tweets

  devise_scope :user do
    authenticated :user do
      root :to => 'socials#index'
    end
    unauthenticated :user do
      root :to => 'socials#homepage', as: :unauthenticated_root
    end
  end
end

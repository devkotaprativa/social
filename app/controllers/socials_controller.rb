class SocialsController < ApplicationController
  before_filter :authenticate_user!, :except => [:homepage]
  before_filter :get_client
  def index
    unless TwitterOauthSetting.find_by_user_id(current_user.id).nil?
      redirect_to "/twitter_profile"
    end
  end

  def create
     
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def homepage
  end

  def generate_twitter_oauth_url
    oauth_callback = "http://#{request.host}:#{request.port}/oauth_account"
    @consumer = OAuth::Consumer.new("ySySPXIPjoylhnqMkIs7OeMzQ","MLMWWVnQjVGioc0pB70iGI3tKSTb7H6UGbiXxglLPo8NmleyAc", :site => "https://api.twitter.com")
    @request_token = @consumer.get_request_token(:oauth_callback =>oauth_callback)
    session[:request_token] = @request_token
    redirect_to @request_token.authorize_url(:oauth_callback => oauth_callback)
  end

  def oauth_account
    if TwitterOauthSetting.find_by_user_id(current_user.id).nil?
      @request_token = session[:request_token]
      prepare_access_token(params[:oauth_token],params[:oauth_token_secret])
      @consumer = OAuth::Consumer.new(params[:oauth_token],params[:oauth_token_secret], :site => "https://api.twitter.com")
      Rails.logger.info"+++++++++++++++++++++++"
      Rails.logger.info("#{@request_token.inspect}")
      Rails.logger.info"+++++++++++++++++++++++"
      @access_token = prepare_access_token(params[:oauth_token],params[:oauth_token_secret])
      TwitterOauthSetting.create(atoken: @access_token.token, asecret: @access_token.secret, user_id: current_user.id)
      
    end
    redirect_to "/twitter_profile"
  end

  def twitter_profile
    @user_timeline = @client.user_timeline
    @home_timeline = @client.home_timeline

  end

  private
  def get_client
    
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["CONSUMER_KEY"]
      config.consumer_secret = ENV["CONSUMER_SECRET"]
      config.access_token = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end

     Twitter::Client.new(
      :oauth_token => TwitterOauthSetting.find_by_user_id(current_user).atoken,
      :oauth_token_secret => TwitterOauthSetting.find_by_user_id(current_user).asecret)
      
  end

  def prepare_access_token(oauth_token, oauth_token_secret)
      #consumer = OAuth::Consumer.new("APIKey", "APISecret", { :site => "https://api.twitter.com", :scheme => :header })
      @consumer = OAuth::Consumer.new("ySySPXIPjoylhnqMkIs7OeMzQ","MLMWWVnQjVGioc0pB70iGI3tKSTb7H6UGbiXxglLPo8NmleyAc", { :site => "https://api.twitter.com", :scheme => :header })

      # now create the access token object from passed values
      token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
      access_token = OAuth::AccessToken.from_hash(@consumer, token_hash )
      return access_token
  end

  
end

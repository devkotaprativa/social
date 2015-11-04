class TweetsController < ApplicationController
  def create
  	current_user.tweet(twitter_params[:message])
  	flash[:notice] = "Successfully Tweeted"
  	redirect_to twitter_profile_path
  end

  def new
  	@post = Tweet.new
  end

  private
  def twitter_params
    params.require(:tweet).permit(:message)
  end

  
end

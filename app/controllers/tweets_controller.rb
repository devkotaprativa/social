class TweetsController < ApplicationController
  def create
  	if current_user.tweet(twitter_params[:message])
  		flash[:notice] = "Successfully Tweeted"
  		redirect_to twitter_profile_path
  	else
  		flash[:notice] = "Sorry your tweet cannot be posted"
  end

  def new
  	@post = Tweet.new
  end

  private
  def twitter_params
    params.require(:tweet).permit(:message)
  end

  
end

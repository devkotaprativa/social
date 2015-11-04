module ApplicationHelper
  require 'twitter-text'
  include Twitter::Autolink

	def resource_name
    :user
  end

  def resource_class 
     User 
  end

  def resource
    @resource ||= User.new
    
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
 
  def twitter_text(text)
    text = auto_link(text)
    text ? text.html_safe : ''
  end
end

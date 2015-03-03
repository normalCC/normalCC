class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  #before_action :admin_user, only:[:home, :index, :destroy] #no implicit conversion of Symbol into Integer?

  private 

  # Debugging function to show the contents of an ActiveRecord collection.
  # Use this in a controller: render json: output_ar(@questions)
  def output_ar(collection)
    # To be able to read it, even if it's not a collection, make sure
    # it's a collection by wrapping it in   [ ]
    collection = Array.wrap(collection)  
    collection = collection.map { |i| i.attributes }
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end
#   For EDITING AND UPDATING THE USER
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

# This function is causing problems to our rake tasks.
#  wg moved this to the question and answer models
  # def stop_words
  #   if title.present? && title.include?("monkey")
  #   errors.add(:title, "Please don't use monkey!")
  #   end
  # end

end

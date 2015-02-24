module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end
# remembers a user in a persisant session.
# check Config/initializers/ sessions_store.rb for
# remember length Ie. week/day/hour
# You could also set a remember token length as def cookies
# => cookies[:remember_token] = {value: remember_token,
# => expires: 1.hour.from_now.utc}
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
# To CHECK FOR current USER in the #before_action :correct_user. from user controller
# Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
# return current user if any
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?( cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
# returns true if user logged in
  def logged_in?
    !current_user.nil?
  end
#forget the session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
# log out current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
# Redirects to stored location or to the default location for
# => friendly forwarding
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
#Store the url that was trying to be accesed..
# SO THIS AND THEN ONE ABOVE allow if the session times out
# And the user logs in again it will return them to the page that
# They where on before having to login again.  
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end

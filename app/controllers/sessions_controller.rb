class SessionsController < ApplicationController
  def new

  end

  def create
    # render text: session[:forwarding_url]
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
      #login the user and redirect to the show page
        log_in user
        remember user
      #params[:session][:remember_me] == '1' ? rememeber(user) : forget(user)
      #If we want the remember me button option.
        redirect_back_or user
      else
      #create error
        flash.now[:danger] = "Invalid email or password" #.now removes persistant flash message
        render 'new'
    end
  
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url #POSSIBLE TO LOGGED OUT PAGE???? lookinto
  end


end

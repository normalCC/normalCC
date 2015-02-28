class UsersController < ApplicationController
  before_action :logged_in_user, only: [:home, :index, :destroy] #:home? #:edit, :update,
  #before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy #:home, :index?

  def new
     @user = User.new 
  end

  def home
    @users = User.all
    #@user = User.find(params[:id]) 
  end

  def index
    #@questions = Question.all
    @users = User.all
    #@users = User.paginate(page: params[:page])
  end

  def show 
    #@questions = Question.all
    @user = User.find(params[:id]) 
  end

  def create
    @user = User.new(user_params)
    # get user's current IP address, this will get translated into latitude and longitude after_validation via User Model. 
    @user.ip_address = request.remote_ip            # BUG WITH THIS LINE
    
    if @user.save
      log_in @user
      flash[:success] = "LOGGED IN "
      redirect_to @user
    else
      render 'new'
    end
  end
#NOT PLANNING ON EDITING USER PROFILE< BUT INCASE WE WANT TO ADD IT
  #def edit
  #  @user = User.find(params[:id])
  #end

  #def update
  #  @user = User.find(params[:id])
  #  if @user.update_attributes(user_params)
  #    flash[:success] = "Profile updated"
  #    redirect_to @user
  #  else
  #    render 'edit'
  #  end
  #end

  def destroy
    User.find(params[:id]).destroy
    flash[:succes] = "User deleted"
    redirect_to users_url
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password,
       :password_confirmation, :birth_year, :female, :male)
      #params.require(:user).permit(:name, :email)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
# For EDITING AND UPDATING THE USER
    #def correct_user
    #  @user = User.find(params[:id])
    #  redirect_to(root_url) unless current_user?(@user)
    #end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end

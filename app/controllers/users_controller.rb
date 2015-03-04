class UsersController < ApplicationController
  before_action :logged_in_user, only: [:home, :index, :destroy] #:home? #:edit, :update,
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :home, :make_admin] #no implicit conversion of Symbol into Integer?
  #before_action validates :admin
  #before_action :authenticate_admin!, only: [:index, :destroy, :make_admin]
  #before_action :authenticate_user!, only: [:edit, :update]

# the root path comes to here, if the user is logged in then they go straight 
# to a new question.
  def new
    if logged_in?
      @user = current_user
      @question = Question.first
      @answer = Answer.new
      # render json: output_ar(@question)
      redirect_to question_path(@question)
    else
      @user = User.new 
    end
  end

  def home
    @users = User.all
    #@admin = admin_user
    #@user = User.find(params[:id]) 
  end

  def index
    @user = User.new  # added to let users sign up on index page
    #@questions = Question.all
    # @users = User.all
    #@users = User.paginate(page: params[:page])
  end

  def show 
    @user = User.find(params[:id]) 
    @questions = Question.where("user_id":@user)
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
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:succes] = "User deleted"
    redirect_to home_url
  end

  def make_admin
    @user = User.find(params[:id])
    if @user.admin
      @user.admin = false
      @user.save
      redirect_to users_path
    else @user.admin
      @user.admin = true
      @user.save
      redirect_to users_path
    end
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password,
       :password_confirmation, :birth_year, :female, :admin)
      #params.require(:user).permit(:name, :email)
    end
end

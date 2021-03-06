class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :show, :destroy, :index, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

    respond_to do |format|
      format.html #show.html.erb
      format.json { render json: @microposts, json: @users }
    end
  end

  ## How to make index only available to admin users
  def index
    ## This option should be only available to Admin users : not all the users
    #@users = User.all
    @users = User.paginate(page: params[:page])

    respond_to do |format|
      format.html  #index.html.erb
      format.json { render json: @users }
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    #puts @user.avatar = params[:avatar]
    #@user.avatar = File.open('somewhere')

    if @user.save
      # Handle a successful save.
      #@user.avatar.url # => '/url/to/file.png'
      #@user.avatar.current_path # => 'path/to/file.png'
      #@user.avatar.identifier # => 'file.png'

      sign_in @user
      flash[:success] = "Welcome to the Sample App! #{@user.avatar.current_path}"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:avatar)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end

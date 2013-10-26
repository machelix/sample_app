class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
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
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:avatar)
  end

end

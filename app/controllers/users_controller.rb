class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  
  def show
   @user = User.find(params[:id]) 
   @posts = @user.posts.paginate(page: params[:page])
   @post = current_user.posts.build if logged_in?
   
  end 


  def new
  	@user = User.new 
  end

  def create
     @user = User.new(user_params)
     if @user.save
     	flash[:success] = "Welcome to Votester!"
       log_in @user
       render 'edit' 
     else 
        render 'new'
     end 
  end 

  def edit
      @user = User.find(params[:id]) 
  end

  def update
  	  @user = User.find(params[:id])
  	  if @user.update_attributes(user_edit_params)
  	  	# handle succesful update
  	  	flash[:success] = "Profile updated"
        redirect_to root_url
  	  else 
  	  	render 'edit'
  	  end 
  end 

  private 

    def user_params 
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 

    def user_edit_params 
    	params.require(:user).permit(:name, :email, :location, :bio)
    end 

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def private_user
      @user = User.find(params[:id])
      
    end


end

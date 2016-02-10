class StaticPagesController < ApplicationController
  def home
  	@user = User.new
  	@feed_items = @user.feed.paginate(page: params[:page])
    if logged_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def show
    
   @posts = @user.posts.paginate(page: params[:page])
   
  end 
end

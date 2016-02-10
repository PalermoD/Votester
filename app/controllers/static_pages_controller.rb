class StaticPagesController < ApplicationController
  def home
  	@user = User.new
    @post = current_user.posts.build if logged_in?
  end
end

class CommentsController < ApplicationController
	before_action :set_post
	

	def create  
     @comment = @post.comments.build(comment_params)
     @comment.user = current_user


  

  if @comment.save
    flash[:success] = "You commented the hell out of that post!"
    redirect_to :back
  else
    flash[:alert] = "Check the comment form, something went horribly wrong."
    render root_path
  end
end

	def destroy  
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    flash[:success] = "Comment deleted :("
    redirect_to :back
  end   


	private 

	   def comment_params
	   	  params.require(:comment).permit(:content)
	   end 

	   def set_post  
          @post = Post.find(params[:post_id])
       end 

       def set_user 
          @user = User.find(params[:user_id])
       end 
end

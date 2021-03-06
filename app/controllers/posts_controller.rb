class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

	def new
	  @post = Post.new 
    
	end 

	def index
    @posts = Post.all
  end

  def show
   @post = Post.find(params[:id]) 
  
  
  end 

	def create
       @post = current_user.posts.build(post_params)
       
       if @post.save
       	flash[:success] = "post created!"
       	redirect_to :back
       else
       	@feed_items = []
       	render 'static_pages/home'
       end
    end

    def destroy
    	 @post.destroy
         flash[:success] = "Post deleted"
         redirect_to root_url
    end 


    # def upvote 
    #    @post = Post.find(params[:id])
    #    @post.upvote_by current_user
    #    redirect_to :back
    # end 

    def upvote
        @post = Post.find(params[:id])

        respond_to do |format|
        unless current_user.voted_for? @post
          format.html { redirect_to :back }
          format.json { head :no_content }
          format.js { render :layout => false }
          @post.cached_votes_total = @post.cached_votes_total + 1 
          @post.save
          @post.upvote_by current_user
        else
          flash[:danger] = 'You allready voted this entry'
          format.html { redirect_to :back }
          format.json { head :no_content }
          format.js
        end
      end
    end 


    def downvote
        @post = Post.find(params[:id])
        
        respond_to do |format|
        unless current_user.voted_for? @post
          format.html { redirect_to :back }
          format.json { head :no_content }
          format.js { render :layout => false }
          @post.cached_votes_total = @post.cached_votes_total + 1
          @post.save
          @post.downvote_by current_user
        else
          flash[:danger] = 'You allready voted this entry'
          format.html { redirect_to :back }
          format.json { head :no_content }
          format.js
        end
      end
    end 

    # def downvote
    #    @post = Post.find(params[:id])
    #    @post.downvote_by current_user
    #    redirect_to :back
    #  end

    private 

      def post_params
      	params.require(:post).permit(:content, :picture)
      end

      def correct_user
         @post = current_user.posts.find_by(id: params[:id])
         redirect_to root_url if @post.nil?
      end

      # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 10.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end

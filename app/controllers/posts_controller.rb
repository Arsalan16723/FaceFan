class PostsController < ApplicationController
	before_action :authenticate_user!  
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :owned_post, only: [:edit, :update, :destroy]

	def index
		@posts = Post.all

	end

	def new  
	  @post = current_user.posts.build
	end

	def create  
	   @post =current_user.posts.build(post_params)
	   if @post.save
	  	flash[:success] = "Post created at "
	  	redirect_to posts_path
	  else
	  	flash[:alert] = "Error! Post could not be created."
	  	render :new
	  end

	end  

	def show  
	end 

	def edit  
	end 

	def update  

		 if @post.update(post_params)
		 	flash[:success] = "Post updated successfully."
		 else
		 	flash[:alert] = "Error! Post could not be updated."
			redirect_to(post_path(@post))
		end
	end 

	def destroy  
	  if @post.destroy
	  	flash[:danger] = "Post deleted"
	  	redirect_to posts_path
	  else
	  	redirect_to post_path
	  end
	end 
	private

	def post_params  
	  params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end

	def owned_post  
	  unless current_user == @post.user
	    flash[:alert] = "That post doesn't belong to you!"
	    redirect_to root_path
	  end
	end 
end

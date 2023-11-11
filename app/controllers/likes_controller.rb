class LikesController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new
    @like.user = @user
    @like.post = @post
    if @like.save
      redirect_to user_post_url(@user, @post), notice: 'Post liked successfully.'
    else
      flash.now[:error] = 'Failed to like the post.'
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

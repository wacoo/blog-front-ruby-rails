class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @user = current_user
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.post = @post
    if @comment.save
      redirect_to user_post_url(@user, @post), notice: 'Comment created successfully.'
    else
      flash.now[:error] = 'Failed to create a comment.'
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @user = @comment.user
    @post = @comment.post
    authorize! :destroy, @comment

    @post.comments_counter -= 1
    @comment.destroy
    redirect_to user_post_path(@post.author, @post), notice: 'Comment deleted successfully.'
  end
end

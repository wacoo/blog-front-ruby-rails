class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @user = current_user
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])

    @post.comments.each do |c|
      puts "X#{c.user.name} #{c.text}X"
    end
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.post = @post
    puts @post
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
end

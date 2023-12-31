class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :authenticate_user!
  def index
    @post = Post.find_by(id: params[:post_id], author: params[:user_id])
    @comments = @post.comments
    render json: @comments
  end

  def show
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post: @post)
    render json: Comment.find(params[:id])
  end

  def create
    @post = Post.find_by(id: params[:post_id], author: params[:user_id])
    new_comment = current_user.comments.new(comment_params)
    new_comment.post = @post

    if new_comment.save
      render json: { message: 'Comment created successfully.' }, status: :created
    else
      render json: { error: 'Failed to create a comment.' }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

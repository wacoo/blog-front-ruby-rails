class Api::V1::CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery unless: -> { request.format.json? }
  def index
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post: @post)
    render json: @comments
  end

  def show
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post: @post)
    render json: Comment.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.post = @post

    if @comment.save
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

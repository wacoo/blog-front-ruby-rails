class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'application'

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 3)

    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    render json: @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
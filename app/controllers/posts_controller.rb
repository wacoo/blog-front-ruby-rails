class PostsController < ApplicationController
  layout 'application'

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    render 'index'
  end

  def show
    @post = Post.find(params[:id])
    render 'show'
  end
end

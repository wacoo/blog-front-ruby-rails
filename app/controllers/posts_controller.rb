class PostsController < ApplicationController
  layout 'application'

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(:page => params[:page], :per_page => 3)

    render 'index'
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    puts @user.name
    render 'show'
  end

  def new
    @post = Post.new
    @post.author = current_user
    render 'new'
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:success] = 'Post create successfully!'
      redirect_to user_post_path(user_id: current_user.id, id: @post.id)
    else
      flash.now[:error] = 'Failed to create the post.'
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

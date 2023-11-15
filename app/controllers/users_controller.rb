class UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'application'

  def index
    @users = User.includes(:posts)
    render 'index'
  end

  def show
    @user = User.find(params[:id])
    render 'show'
  end
end

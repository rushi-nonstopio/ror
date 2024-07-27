class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    if user_signed_in?
      @posts = Post.where(status: 'published').order(published_date: :desc)
    else
      redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing"
    end
  end

  def show
    # @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated'
    else
      redirect_to @post, alert: 'Error in updating post'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user == current_user
      flash[:alert] = "You are not authorized to perform this action"
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :author, :content, :status, :creation_date, :published_date).merge(user: current_user)
  end
end

class PostsController < ApplicationController
  before_action :require_logged_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  def index
    if @user && @user.admin
      @posts = Post.all.order(created_at: :desc)
    else
      @posts = Post.where.not(published: nil).order(published: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = @user.posts.new
  end

  def create
    @post = @user.posts.new(post_params)
    @post.user_id = @user.id
    @post.published = Date.today if params[:published]
    if @post.save
      redirect_to @post, notice: "Post successfully created!"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.published = Date.today if params[:publish] && @post.published.nil?
    if @post.update(post_params)
      redirect_to @post, notice: "Post successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to posts_path, notice: "Post successfully deleted."
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end

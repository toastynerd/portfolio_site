class PostsController < ApplicationController
  before_action :require_logged_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  def index
    @posts = Post.all
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

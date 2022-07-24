class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  
  
  # =============CREATE========================
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post created successfully!"
      redirect_to post_path(@post)
    else
      render :new
      flash[:notice]= "Body must have more than 50 characters"
    end
  end

  # ================READ========================
  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  # ===============EDIT==========================
  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else 
      render :edit
    end
  end

  # ================DELETE=========================
  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end


end

class PostsController < ApplicationController

  before_action :require_user!, except: :show
  before_action :require_author!, only: [:edit, :update, :destroy]

  def new
    @post = Post.new(sub_ids: [params[:sub_id]])
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to subs_url
    else
      flash.now[:errors] = ["Can't delete someone else's post"]
      render :show
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments_hash = @post.comments_by_parent_id
    @subs = @post.sub_ids.map do |sub_id|
      Sub.find(sub_id)
    end
    render :show
  end

  private
  def require_author!
    post = Post.find(params[:id])
    unless current_user.id == post.author_id
      redirect_to post_url(post)
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end

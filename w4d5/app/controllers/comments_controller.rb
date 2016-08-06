class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end

    redirect_to post_url(@comment.post_id)
  end

  def show
    @comment = Comment.find(params[:id])
    @all_comments_hash = @comment.post.comments_by_parent_id
    render :show
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end

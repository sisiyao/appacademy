class VotesController < ApplicationController

  def upvote
    change_vote(1)
  end

  def downvote
    change_vote(-1)
  end

  private
  def change_vote(value)
    if params.has_key?(:post_id)
      @post = Post.find(params[:post_id])
      @post.count_votes += value
      redirect_to post_url(@post)
    elsif params.has_key?(:comment_id)
      @comment = Comment.find(params[:comment_id])
      @comment.count_votes += value
      redirect_to post_url(@comment.post_id)
    end
  end

end

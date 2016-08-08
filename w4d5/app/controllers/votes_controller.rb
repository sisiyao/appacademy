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
      content = Post.find(params[:post_id])
    elsif params.has_key?(:comment_id)
      content = Comment.find(params[:comment_id])
    end

    content.vote_count += value
    content.save
    redirect_to :back
  end

end

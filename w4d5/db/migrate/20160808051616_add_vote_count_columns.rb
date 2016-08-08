class AddVoteCountColumns < ActiveRecord::Migration
  def change
    add_column :comments, :vote_count, :integer, default: 0, null: false
    add_column :posts, :vote_count, :integer, default: 0, null: false
  end
end

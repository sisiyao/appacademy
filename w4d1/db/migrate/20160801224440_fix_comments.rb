class FixComments < ActiveRecord::Migration
  def change
    remove_column :comments, :someone_id
    add_column :comments, :contact_id, :integer
    add_column :comments, :user_id, :integer
  end
end

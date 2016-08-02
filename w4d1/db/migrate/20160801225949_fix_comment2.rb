class FixComment2 < ActiveRecord::Migration
  def change
    remove_column :comments, :user_id
    remove_column :comments, :contact_id
    add_column :comments, :someone_id, :integer
    add_column :comments, :someone_type, :string
  end
end

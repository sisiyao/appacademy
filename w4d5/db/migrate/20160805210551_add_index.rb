class AddIndex < ActiveRecord::Migration
  def change
    add_index :post_subs, [ :post_id, :sub_id ], unique: true
  end
end

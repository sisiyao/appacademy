class DeleteExtraColumns < ActiveRecord::Migration
  def change
    remove_column :contact_shares, :fav_shared_contact
    remove_column :contact_shares, :fav_shared_id
    remove_column :contacts, :fav_contact_id
  end
end

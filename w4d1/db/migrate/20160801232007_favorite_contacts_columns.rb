class FavoriteContactsColumns < ActiveRecord::Migration
  def change
    add_column :contacts, :fav_contact, :boolean
    add_column :contact_shares, :fav_shared_contact, :boolean
  end
end

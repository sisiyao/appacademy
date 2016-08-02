class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :fav_id, null: false
      t.string :fav_type, null: false
      t.timestamps null: false
    end

    remove_column :contacts, :fav_contact
    remove_column :contact_shares, :fav_contact
    add_column :contacts, :fav_contact_id, :integer
    add_column :contact_shares, :fav_shared_id, :integer
  end
end

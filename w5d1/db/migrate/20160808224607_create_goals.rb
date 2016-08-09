class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :content, null: false
      t.integer :user_id, null: false, index: true
      t.boolean :public_status, null: false, default: true
      t.boolean :completed, null: false, default: false

      t.timestamps null: false
    end
  end
end

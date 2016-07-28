class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.integer :question_id, null: false
      t.string :text, null: false

      t.timestamps null: false
    end
  end
end

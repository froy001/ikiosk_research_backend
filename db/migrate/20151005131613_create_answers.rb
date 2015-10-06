class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.float :value
      t.belongs_to :question, index: true, foreign_key: true
      t.belongs_to :interviewee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

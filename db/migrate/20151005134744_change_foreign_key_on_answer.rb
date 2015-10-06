class ChangeForeignKeyOnAnswer < ActiveRecord::Migration
  def up
    remove_foreign_key :answers, :interviewees
    remove_foreign_key :answers, :questions
    add_foreign_key :answers, :interviewees, on_delete: :cascade
    add_foreign_key :answers, :questions, on_delete: :cascade
  end

  def down
    remove_foreign_key :answers, :interviewees
    remove_foreign_key :answers, :questions
    add_foreign_key :answers, :interviewees
    add_foreign_key :answers, :questions
  end
end

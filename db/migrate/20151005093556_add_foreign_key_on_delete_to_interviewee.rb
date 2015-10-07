class AddForeignKeyOnDeleteToInterviewee < ActiveRecord::Migration
  def up
    remove_foreign_key :interviewees, :kiosks
    add_foreign_key :interviewees, :kiosks, on_delete: :cascade
  end

  def down
    remove_foreign_key :interviewees, :kiosks
    add_foreign_key :interviewees, :kiosks, on_delete: :restrict
  end
end

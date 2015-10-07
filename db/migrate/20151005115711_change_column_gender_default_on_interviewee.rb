class ChangeColumnGenderDefaultOnInterviewee < ActiveRecord::Migration
  def up
    change_column :interviewees, :gender, :integer, default: 0, :null => false
  end

  def down
    change_column_default :interviewees, :gender, nil
    change_column_null :interviewees, :gender, true
  end
end

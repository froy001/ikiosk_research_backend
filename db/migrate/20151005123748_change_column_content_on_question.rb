class ChangeColumnContentOnQuestion < ActiveRecord::Migration
  def up
    change_column_null :questions, :content, false
  end

  def down
    change_column_null :questions, :content, true
  end
end

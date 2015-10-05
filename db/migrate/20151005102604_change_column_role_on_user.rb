class ChangeColumnRoleOnUser < ActiveRecord::Migration
  def up
    change_column :users, :role, :integer, :default => 0, :null => false
  end

  def down
    change_column_default :users, :role, :integer, nil
    change_column :users, :role, :integer, :null => true
  end
end

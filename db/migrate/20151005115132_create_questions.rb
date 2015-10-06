class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :type, default: 0, :null => false

      t.timestamps null: false
    end
  end
end

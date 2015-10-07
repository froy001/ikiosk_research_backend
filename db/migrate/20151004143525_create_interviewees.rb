class CreateInterviewees < ActiveRecord::Migration
  def change
    create_table :interviewees do |t|
      t.string :name
      t.references :kiosk, index: true, foreign_key: true
      t.string :street
      t.string :city
      t.float :latitude, null: false, :percision => 10, :scale => 7
      t.float :longitude, null: false, :percision => 10, :scale => 7
      t.integer :age
      t.integer :gender

      t.timestamps null: false
    end
    add_index :interviewees, :latitude
    add_index :interviewees, :longitude
  end
end

class CreateKiosks < ActiveRecord::Migration
  def change
    create_table :kiosks do |t|
      t.string :name, limit: 20
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :street, limit: 30
      t.string :city, limit: 30

      t.timestamps null: false
    end
    add_index :kiosks, :latitude
    add_index :kiosks, :longitude
  end
end

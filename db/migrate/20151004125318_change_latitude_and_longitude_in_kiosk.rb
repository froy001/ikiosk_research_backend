class ChangeLatitudeAndLongitudeInKiosk < ActiveRecord::Migration
  def up
    change_column :kiosks, :latitude, :float, :percision => 10, :scale => 7
    change_column :kiosks, :longitude, :float, :percision => 10, :scale => 7
  end

  def down
    change_column :kiosks, :latitude, :float, :percision => 4, :scale => 3
    change_column :kiosks, :longitude, :float, :percision => 4, :scale => 3
  end
end

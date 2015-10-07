class Kiosk < ActiveRecord::Base
  validates :name, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true

  has_many :interviewees
end

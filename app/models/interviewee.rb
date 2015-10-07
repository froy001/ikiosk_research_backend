class Interviewee < ActiveRecord::Base
  enum gender: [:female, :male]
  belongs_to :kiosk
  has_many :answers, dependent: :destroy

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end

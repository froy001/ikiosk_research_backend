class Question < ActiveRecord::Base
  enum question_type: [:numeric]
  has_many :answers

  validates :content, presence: true
end

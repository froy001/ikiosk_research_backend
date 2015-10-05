class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :interviewee

  validates :interviewee, presence: true
end

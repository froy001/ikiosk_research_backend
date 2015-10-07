FactoryGirl.define do
  factory :answer do
    sequence(:value) { |n| 1.5 + n / 100.1}
    question
    interviewee
  end
end

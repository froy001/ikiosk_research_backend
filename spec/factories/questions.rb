FactoryGirl.define do
  factory :question do
    sequence(:content) { |n| "Content#{n}"}
    sequence(:question_type) { 0 }

    factory :question_with_answers do
      transient do
        answer_count 5
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answer_count, question: question)
      end
    end
  end
end

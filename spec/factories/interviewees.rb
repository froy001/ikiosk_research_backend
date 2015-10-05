FactoryGirl.define do
  factory :interviewee do
    sequence(:name) { |n| "MyName#{n}"}
    sequence(:street) { |n| "MyStreet#{n}"}
    sequence(:city) { |n| "MyCity#{n}"}
    sequence(:latitude) { |n| 31.7 + (n/100.3)}
    sequence(:longitude) { |n| 35.2 + (n/100.3)}
    sequence(:age) { |n| "MyAge#{n}"}
    sequence(:gender) { |n| (n % 2)}
    kiosk

    factory :interviewees_with_answer do
      transient do
        answer_count 5
      end

      after(:create) do |interviewee, evaluator|
        create_list(:answer, evaluator.answer_count, interviewee: interviewee)
      end
    end
  end

end

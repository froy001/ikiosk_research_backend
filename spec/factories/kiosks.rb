FactoryGirl.define do
  factory :kiosk do
    sequence(:name) { |n| "kiosk#{n}"}
    sequence(:latitude) { |n| 31.7 + (n/100.3)}
    sequence(:longitude) { |n| 35.2 + (n/100.3)}
    street "MyString"
    city "MyString"

    factory :kiosk_with_interviewees do
      transient do
        interviewees_count 5
      end

      after(:create) do |kiosk, evaluator|
        create_list(:interviewee, evaluator.interviewees_count, kiosk: kiosk)
      end
    end
  end
end

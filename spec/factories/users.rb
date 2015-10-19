FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User#{n}"}
    sequence(:email) { |n| "test#{n}@example.com"}
    sequence(:password) { |n| "please123#{n}}" }
    confirmed_at Time.now

    trait :admin do
      role 'admin'
    end

  end
end

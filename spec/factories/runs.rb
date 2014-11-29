# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :run do
    distance 2.01

    trait :with_increasing_distance do
      sequence(:distance) { |n| n + 0.5 }
    end
  end
end

FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    email {Faker::Internet.email}
    password 'please123'

    trait :admin do
      role 'admin'
    end

    trait :with_increasing_distance do
      sequence(:total_distance) { |n| n + 0.5 }
    end

    trait :with_increasing_walking_distance do
      after :create do |user|
        FactoryGirl.create(:run, runtype: :walk, user:user)
      end
    end

  end
end

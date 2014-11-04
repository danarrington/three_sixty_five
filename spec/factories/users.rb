FactoryGirl.define do
  factory :user do
    name "Test User"
    email {Faker::Internet.email}
    password "please123"

    trait :admin do
      role 'admin'
    end

  end
end

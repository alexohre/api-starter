# In spec/factories/users.rb

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :with_host do
      after(:build) do |user, evaluator|
        user.default_url_options[:host] = evaluator.host
      end
    end
  end
end

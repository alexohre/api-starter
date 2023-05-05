# In spec/factories/accounts.rb

FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :with_host do
      after(:build) do |account, evaluator|
        account.default_url_options[:host] = evaluator.host
      end
    end
  end
end
